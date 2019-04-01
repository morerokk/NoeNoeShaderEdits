This pack features a bunch of edits of Noenoe shaders. All edits have been done to the "Toon" subsection. The Overlay shaders (including PBR) are unchanged.

- Every shader now has Metallic support
- Every shader now has an alpha cutoff slider, even Transparent
- Every shader now has a sidedness selection (front sided, back sided, double-sided)
- Renamed Opaque to Cutout to be more compatible with the shader fallback system
- Added "Vertex Offset" shader under Overlay/Misc. This shader features properties like Position, Rotation and Scale within the shader. Can be animated. Great for niche uses that would otherwise break the IK, such as up/down floating animations, upside-down models, or scaling.
- All shaders can now use the world's directional light direction. The Static Toon Light direction will be used as a "fallback" if there are no Realtime/Mixed directional lights. You can still force your own light direction if you wish.

Large improvements to the outline shader:
- Added an "outer only" outline mode. In this mode, outlines will not be rendered over the model, only on the outer edges. Good for avoiding artifacts and for stylistic effect.
- Added support for tinted outlines. You can now supply an outline texture that will be used, rather than only being able to use solid colors. The texture's alpha channel additionally determines the thickness of the outline in that area.
- Outlines can optionally use Cutout

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