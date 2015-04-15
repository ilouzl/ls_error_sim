function Scatter2Surf(x,y,z)

% %% Little triangles
% % The solution is to use Delaunay triangulation. Let's look at some
% % info about the "tri" variable.
% 
tri = delaunay(x,y);
% plot(x,y,'.')

%%
% How many triangles are there?

[r,c] = size(tri);

%% Plot it with TRISURF

h = trisurf(tri, x, y, z);
xlabel('X'); ylabel('Y'); zlabel('Z');
% axis vis3d

%% Clean it up

% axis off
% l = light('Position',[-50 -15 29])
% set(gca,'CameraPosition',[208 -50 7687])
% lighting phong
% shading interp
% colorbar EastOutside