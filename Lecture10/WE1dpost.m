% WE1d post processing script 
% create images and movies
% Run WE1D.m before running this script!

% Name of the file to save
aviname = 'WE1Dmovie/WE1D2s.avi';
% name (and location) of (png) files to save images
pngname = 'WE1Dmovie/WE1D2s';

%% Plotting - simple plot 
figure; 
  plot(x, u(1,:), 'r-',x, u(2,:), 'k-', x, u(end,:), 'b-');
  xlabel('x');
  ylabel('u(x,t)');
  

%% Creating a movie frame
v = VideoWriter(aviname,"Motion JPEG AVI");
v.FrameRate = 10;
open(v);
umax = max(max(u)); umin = min(min(u));
f1 = figure; f1.MenuBar = "none"; f1.ToolBar = "none";
idmov = 1;
  plot(x, u(1,:), 'k-');
  xlabel('x');
  axis([0 L umin umax]);
  title(sprintf('t = %5.2f',t(idmov)));
  % This has to be used if a movie-file is created
  frame = getframe(f1);
  writeVideo(v,frame);
  % Next line should be used if a sequence of png files are created
  % print(sprintf('%s_%04d.png',idmov), pngname, '-dpng');
  ax = gca;
  ax.NextPlot = "replacechildren";
  for idt=2:length(t)
    idmov = idmov + 1;
    plot(x, u(idt,:), 'r-');
    title(sprintf('t = %5.2f',t(idmov)));
    pause(0.05);
    % This has to be used if a movie-file is created
    frame = getframe(f1);
    writeVideo(v, frame);
    % Next line should be used if a sequence of png files are created
    % print(sprintf('%s_%04d.png',idmov), pngname, '-dpng');
  end

close(v);
