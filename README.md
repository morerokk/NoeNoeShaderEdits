# NoeNoe Shader Edits

This is an edit of [NoeNoe Shaders, originally made by Noe.](https://vrcat.club/threads/updated-29-5-18-noenoe-shaders.157/) All the edits have been made to the "toon" variants, the other variants are untouched.

# Feature Overview

Quick list of changes:

* All shaders can now use the world's light direction. The Static Toon Light direction will be used as a "fallback" if the world has no meaningful light direction. You can still force your own light direction if you wish. World light direction also works in baked-only worlds.
* Completely overhauled editor GUI
* Every shader now has optional Metallic and Specular support
* Every shader now has an alpha cutoff slider, even Transparent
* Every shader now has a sidedness selection (front sided, back sided, double-sided). Transparent is still one-sided by default, because it can sometimes give artifacts when opacity is decreased.
* Renamed Opaque to Cutout to be more compatible with the shader fallback system
* Added "Vertex Offset" shader under Overlay/Misc. This shader features properties like Position, Rotation and Scale within the shader. These properties can be animated. Great for niche uses that would otherwise break the IK, such as up/down floating animations, upside-down models, or scaling.
* Optional support for receiving shadows (including self-shadowing).
* Added additive and multiplicative matcap support to each shader
* Added local shader keywords to improve performance a bit

The self-shadowing is not always desirable, which is why the option is off by default. If desired, you can also turn off Cast Shadows on the mesh renderer instead, allowing you to still receive shadows properly.

A bunch of changes to the outline shader:

* Added "outer-only" outlines mode, which will only render outlines on the outer edges of the model. Great for avoiding artifacts or for stylistic effect.
* Outlines are no longer unlit
* Outlines can accept an "outline texture". Setting this to your main texture will give you tinted outlines. The texture's alpha also determines the outline width.

# Ramp Masking

An entirely new and slightly experimental "Ramp Masked" shader has been added. This shader is the same as Cutout, but allows you to define up to *four* different toon ramps on the same material, as well as separately configurable contrast, saturation and intensity values for each of them. Great for applying different toon ramp colors to the skin and the clothes, for example.

To use this feature, you have to first make a copy of the texture. Open the copy in any image editor, such as GIMP or even paint. Give every area of the texture its own solid
color, depending on the toon ramp setup you need. The shader supports the following four colors:

Black: default settings  
Red: R settings  
Green: G settings  
Blue: B settings  

Using other colors might result in unexpected behavior.

For performance reasons, make the mask texture as small as you can without any quality loss. A 4096x4096 mask texture can often easily be set to import at a much lower resolutions in Unity (such as 256x256),
without any loss in quality. Crunch compression will also make a large difference in filesize without sacrificing quality.

A premade skin-colored toon ramp is included ("toon_skin_hq"). Toon ramps are expected to be horizontal with dark on the left and light on the right, or vertical with dark on the bottom and light on the top. This means that MMD toon ramps are compatible.

You should set the texture mode of the toon ramp texture to "Clamp" in Unity, to avoid very ugly artifacts.

# Metallic

An experimental feature that adds metallic support, similar to Standard. Metallic maps use the Red channel for Metallic and Alpha for Smoothness. Smoothness doesn't do anything by itself, a lower smoothness simply blurs the reflections that you see on Metallic. Metallic on Transparent works similarly to Fade, so the reflections are faded out too.

# Eye Tracking
The shader now features an experimental eye tracking version! This makes the mesh face the camera. However, the eyes will occasionally look ahead. This behavior is entirely determined by the "pattern texture", a black and white gradient that scrolls from left to right. When the current pixel is black, the eyes will look straight ahead normally. When the pixel is white, the eyes will look towards the camera. In-between values are also supported, allowing for smooth transitions. The scroll speed and blur factor can be changed. For best results, set the wrap mode of the texture to Repeat or Mirror. Two sample textures are included to show off how it works.

For VR, it can also be configured to face either the left eye, right eye or center of the eyes. The character's left eye should look at the right eye and vice-versa, for best effect.

To use this feature, the mesh has to be a non-skinned mesh not affected by an armature. Rather, it should be a non-skinned mesh parented to the character's head, with the origin point of the mesh as the pivot point of the eye. Refer to [Vilar's Eye Tracking Shader](https://github.com/Vilar24/VilarVRC) for setup instructions.