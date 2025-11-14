## Implementing Cubemaps as well as some other shaders within a Custom Engine for USC's CSCI-522

Shaders in the prime engine are *.cgps* and *.cgvs* files, representing pixel and vertex shaders respectively. 
I highly recommend looking at the pipeline responsible for loading and drawing an object in completion in order to understand how shaders are assigned and processed. 
Shaders can be set in the *.lua* or *.mata* file of an object, if you make a few changes. 
I allowed for there to be a *technique* defined in these files, which then tells the renderer which shader to use for the object. 
Make sure to allow the engine to default to a shader if it can’t find the one defined in the *.lua* or *.mata* file. 
Not doing so results in a crash if the shader is not present. There are also changes to be made in the *EffectsManager.cpp* and *EffectManagerEffects.cpp* files.

**Cubemaps:**

First, obtain the vector from the camera to the pixel being drawn. 
Reflect this vector in the opposite direction w.r.t the normal of the pixel. 
Use the reflected vector to calculate texture co-ords to sample the cubemap. 
*A method to calculate the co-ordinates can be found in samplerhelper.fx.* 
In essence, you just need to pick the right face of the cube depending on the direction of the vector obtained. 
You then use the calculated co-ordinates to sample the cubemap.

**CelShaded Look:**

A simple Pixel Shader that checks the intensity of the light at a particular spot and accordingly places the pixel into one of many bands. 
Depending on which band the pixel falls into, we reduce the color of the pixel. 
This creates some very visible bands, but it is not true cel shading, especially since you would want to reduce the number of possible colors for a true effect, which is not done here. 
I couldn’t figure out how to multipass render within the engine either, so outlines were left as a post process using the Sobel method.

**Outlines as a Post-Process:**

This is a post process shader (make sure to use it in engine as such). 
We are just using the Sobel method of detecting an edge, and if an edge is detected, we change the pixel out color to black, or we just keep it as is.
Additionally, some pre-processing of the SceneTexture could help in this shader working a bit better, but is not present here.