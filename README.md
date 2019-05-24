# GameGraphicsHW3

Download Build: http://Ianrapoport.com/IanRapoportHW3.zip

How to use. Once the scene has loaded, use the up and down arrows to change the noise of the particle effect. 
Press escape to exit the build.

Part A: 

For my project, I tried to adapt a fire particle. My shader (Assets/Shaders/TrailShader.shader) 
is essentially the same as the one we made for lab 6, except it lerps the start and end colors based
on a lerp value property. For noise, I used the noise built into Unity particle systems.

I read in audio using the script we used from lab 7 (Assets/Scripts/AudioPeer.cs). I adjust the particle 
using the a script adapted from the tree bend script from lab 7 (Assets/Scripts/ConvertAudio.cs). It
basically just takes the magnitude and clamps it, then passes it in as the lerp value for the shader.
The higher the magnitude, the closer the color gets to blue. The magnitude also effects the noise on
particle. High magnitude means more noise. You can adjust the max noise by pushing up and down on the 
keyboard.

Part B Assets/Homework\ 3\ B.pdf

The music is not mine. It was made by Fernando Zamora.
