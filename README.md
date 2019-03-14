# NoeNoe Shader Edits

This is an edit of [NoeNoe Shaders, originally made by Noe.](https://vrcat.club/threads/updated-29-5-18-noenoe-shaders.157/) All the edits have been made to the "toon" variants, the other variants are untouched.

# Feature Overview

Quick list of changes:

* Every shader now has an alpha cutoff slider, even Transparent
* Every shader now has a sidedness selection (front sided, back sided, double-sided). Transparent is still one-sided by default, because it can sometimes give artifacts when opacity is decreased.
* Renamed Opaque to Cutout to be more compatible with the shader fallback system
* Added "Vertex Offset" shader under Overlay/Misc. This shader features properties like Position, Rotation and Scale within the shader. These properties can be animated. Great for niche uses that would otherwise break the IK, such as up/down floating animations, upside-down models, or scaling.
* All shaders can now use the world's directional light direction. The Static Toon Light direction will be used as a "fallback" if there are no Realtime/Mixed directional lights. You can still force your own light direction if you wish.

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

A premade skin-colored toon ramp is included ("toon_skin_arlvit"). You can use toon ramps from other sources, such as MMD or other shaders. Keep in mind that this shader expects a horizontal toon ramp, with dark on the left and light on the right. MMD toon ramps will probably have to be rotated 90 degrees clockwise.
You should also set the texture mode to "Clamp" in Unity to avoid very ugly artifacts.