This pack features a bunch of edits of Noenoe shaders. All edits have been done to the "Toon" subsection. The Overlay shaders (including PBR) are unchanged.

- All shaders can now use the world's directional light direction. The Static Toon Light direction will be used as a "fallback" if there is no meaningful light direction. You can still force your own light direction if you wish.
- Improved lighting model that better supports HDR and supports colored lights, but stays true to the original Noenoe look (the legacy lighting mode is still available)
- Completely overhauled editor GUI
- Every shader now has optional Metallic and Specular support
- Every shader now has an alpha cutoff slider, even Transparent
- Every shader now has a sidedness selection (front sided, back sided, double-sided)
- Added "Vertex Offset" shader under Overlay/Misc. This shader features properties like Position, Rotation and Scale within the shader. Can be animated. Great for niche uses that would otherwise break the IK, such as up/down floating animations, upside-down models, or scaling.
- Added option for receiving shadows. This includes self-shadowing. This doesn't always look good, so it is off by default. If desired, you can also turn off Cast Shadows on the mesh renderer instead, allowing you to still receive shadows properly.
- Added additive and multiplicative matcap support
- Added and improved overlay support to the toon shaders. This effectively makes the "Lit Overlay" family of shaders a legacy thing, and may be removed in the future.
- Added rimlight options. Try using subtle rimlights on skin! RGB controls color, A controls strength.

Large improvements to the outline shader:
- Added an "outer only" outline mode. In this mode, outlines will not be rendered over the model, only on the outer edges. Good for avoiding artifacts and for stylistic effect.
- Added support for tinted outlines. You can now supply an outline texture that will be used, rather than only being able to use solid colors. The texture's alpha channel additionally determines the thickness of the outline in that area.
- Outlines can optionally use Cutout

Overlay support has been ported to the "toon" shader and has been improved upon a little. Supports panospheres and cubemaps. Panospheres will look weird around the top/bottom unless you use a texture meant for it.

This pack also adds a "ramp masked" version of the Cutout shader. Essentially, this uses a mask texture to allow you to define up to *four* different toon ramps,
toon contrast, intensity and saturation values, all on the same material. Great for applying a skin-colored toon ramp to the skin without having to separate the material,
for example. This can also be used to have harsher toon ramps on the body than on the face.

To use this feature, you have to first make a copy of the texture. Open the copy in any image editor, such as GIMP or even paint. Give every area of the texture its own solid
color, depending on the toon ramp setup you need. The shader supports the following four colors:

Black: default settings
Red: R settings
Green: G settings
Blue: B settings

Using other colors might result in unexpected behavior.

For performance reasons, make the mask texture as small as you can without any quality loss. A 4096x4096 mask texture can often easily be set to import at a much lower resolutions in Unity (such as 256x256),
without any loss in quality. Crunch compression will also make a large difference in filesize without sacrificing quality.

A premade skin-colored toon ramp is included ("toon_skin_hq"). You can use toon ramps from other sources, such as MMD. The shader normally expects a horizontal toon ramp, with dark on the left and light on the right. However, vertical toon ramps with dark on the bottom and light on the top will also work. This means you can also use MMD toon ramps as-is.

You should set the texture mode to "Clamp" in Unity on the toon ramp texture, to avoid very ugly artifacts.

Experimental Metallic support has been added. You can use the same metallic maps as in Standard (Red is Metallic, Alpha is Smoothness). Smoothness doesn't do anything by itself, lower smoothness only blurs the reflections on the Metallic. Reflections work the same way as Standard.

Eye tracking:
Shader now features an experimental eye tracking version. This makes the mesh face the camera. However, the eyes will occasionally look ahead. This behavior is entirely determined by the "pattern texture", a black and white gradient that scrolls from left to right. When the current pixel is black, the eyes will look straight ahead normally. When the pixel is white, the eyes will look towards the camera. In-between values are also supported, allowing for smooth transitions. The scroll speed and blur factor can be changed. For best results, set the wrap mode of the texture to Repeat or Mirror. Two sample textures are included to show off how it works.

For VR, it can also be configured to face either the left eye, right eye or center of the eyes. The character's left eye should look at the right eye and vice-versa, for best effect.