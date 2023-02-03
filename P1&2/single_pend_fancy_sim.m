% function [] = single_pend_fancy_sim(T, Y, R, L, skip, words);
%
% Dan Davison
% Last modified Apr 17 2019
% Does fancy graphical simulation of the 1-link inverted pendulum.
%
% Inputs:  T = time vector (column vector) 
%          Y = plant data        (col 1 = w,     col 2 = theta    )
%          R = reference signals (col 1 = ref_w, col 2 = ref_theta)
%          L = length of the rod in meters
%          skip = integer used to make the plot less crowded (e.g., = 2 implies plot every 2nd data point only)
%                 Note that "skip" only has an effect if the 'f' option, discussed below, is used.
%          words = title of the plot (optional argument)
%
% Execution:  The user is prompted with 3 options:
%          d = dynamic simulation, i.e., actually show how the system changes over time
%          f = skip the dynamic simulation, and draw a single picture showing how the 
%              system moves about over time [the "skip" argument to the program can be
%              adjusted to make the drawing less crowded]
%          s = skip everything [handy if you are calling this function from another
%              function and don't want to spend time watching the simulation]
%

function [] = single_pend_fancy_sim(T, Y, R, L, skip, words);

savemovie=0;  % manually set to 1 to save dynamic sim as a mp4 file

if nargin < 5
    error('Need to have at least 5 input arguments')
end

deltaT = T(2)-T(1); % assumes uniform sampling

if savemovie  % ddd Apr 3 2019
   disp('*** saving as a mp4 file ***')
   vidObj = VideoWriter('P1(d)_one_rod_movie.mp4','MPEG-4'); set(vidObj,'Quality',100);
   open(vidObj);
end
 

% figure out how to scale so the whole simulation fits on one screen and looks good

xmin = min(Y(:,1))+1.1*(-L);
xmax = max(Y(:,1))+1.1*(L);
ymin = 1.1*(-L);
ymax = 1.1*(L);

ymax = max(ymax, (xmax-xmin)+ymin); 
width = L/8;  % width of the 'cart' is twice this value


c = input('Hit: d for dynamic simulation, f for final plot, s for skip simulation...','s');
c=c(1);
if c=='s'
    return
end

if c=='d'
    dynamic = 1;
    skipterm = 1;  % don't skip much in the dynamic plot
    if savemovie
        skipterm = 2;  % makes the movie file run faster DDD
    end
else  
    dynamic = 0;
    skipterm = skip;  % skip some of the data as the user specifies
end
    
for i = 1:skipterm:length(T)
    
   xposition = Y(i,1);
   theta = Y(i,2);
   
   xposition_ref = R(i,1);
   theta_ref = R(i,2);
  
   % draw cart as a thick line
   h=plot([xposition-width xposition+width],[0 0],'k'); set(h,'linewidth',5);
   hold on
   
   % draw rod 
   t1 = xposition+L*sin(theta);
   t2 = L*cos(theta);
   h=plot([xposition t1],[0 t2],'b'); set(h, 'linewidth',3);
    
   
   if dynamic
 
      % also draw the reference shape in red
      t1_ref = xposition_ref+L*sin(theta_ref);
      t2_ref = L*cos(theta_ref);
      plot([xposition_ref-width xposition_ref+width],[0 0],'r');
      plot([xposition_ref t1_ref],[0 t2_ref],'r');
 
      
      % label plot
      title(sprintf('Time = %f seconds', T(i)'))
      hold off    
      axis([xmin xmax ymin ymax]);
      axis('square')
      xlabel('Base position (m)')
      pause(deltaT)
   else  
      % keep holding plot
   end % if
   
    if savemovie % ddd Apr 3 2019
      currFrame = getframe(gcf);
      writeVideo(vidObj,currFrame);
    end
   
 end % for

axis([xmin xmax ymin ymax]);
axis('square')
if nargin==6
  title(words);
end
hold off

if savemovie % save the movie DDD
   close(vidObj)
end
 
 

