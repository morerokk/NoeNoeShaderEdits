using System;
using UnityEditor;
using UnityEngine;

public class NoeNoeToonEditorGUI : ShaderGUI
{
    //Main
    private MaterialProperty color = null;
    private MaterialProperty mainTex = null;
    private MaterialProperty emissionMap = null;
    private MaterialProperty emissionColor = null;
    private MaterialProperty normalMap = null;
    private MaterialProperty alphaCutoff = null;
    private MaterialProperty sidedness = null;
    private MaterialProperty cutoutMode = null;

    //Toon lighting
    private MaterialProperty staticToonLight = null;
    private MaterialProperty worldLightIntensity = null;
    private MaterialProperty overrideWorldLight = null;
    private MaterialProperty billboardStaticLight = null;
    private MaterialProperty ramp = null;
    private MaterialProperty toonContrast = null;
    private MaterialProperty intensity = null;
    private MaterialProperty saturation = null;
    private MaterialProperty exposure = null;
    private MaterialProperty toonRampDimmingEnabled = null;
    private MaterialProperty exposureToonRampContrast = null;
    private MaterialProperty lightMode = null;

    //Metallic
    private MaterialProperty metallicMode = null;
    private MaterialProperty metallicMap = null;
    private MaterialProperty metallic = null;
    private MaterialProperty smoothness = null;
    private MaterialProperty specularColor = null;
    private MaterialProperty specularMap = null;

    //Ramp mask stuff
    private MaterialProperty rampMaskTex = null;
    private MaterialProperty rampR = null;
    private MaterialProperty toonContrastR = null;
    private MaterialProperty intensityR = null;
    private MaterialProperty saturationR = null;
    private MaterialProperty rampG = null;
    private MaterialProperty toonContrastG = null;
    private MaterialProperty intensityG = null;
    private MaterialProperty saturationG = null;
    private MaterialProperty rampB = null;
    private MaterialProperty toonContrastB = null;
    private MaterialProperty intensityB = null;
    private MaterialProperty saturationB = null;

    //Transparent stuff
    private MaterialProperty opacity = null;
    private MaterialProperty ZWrite = null;

    //Outline stuff
    private MaterialProperty outlineWidth = null;
    private MaterialProperty outlineColor = null;
    private MaterialProperty outlineTex = null;
    private MaterialProperty outlineScreenspace = null;
    private MaterialProperty outlineStencilComp = null;
    private MaterialProperty outlineCutout = null;
    private MaterialProperty outlineAlphaAffectsWidth = null;
    private MaterialProperty outlineScreenspaceMinDistance = null;
    private MaterialProperty outlineScreenspaceMaxDistance = null;

    //Vertex offset stuff
    private MaterialProperty vertexOffset = null;
    private MaterialProperty vertexOffsetWorld = null;
    private MaterialProperty vertexRotation = null;
    private MaterialProperty vertexScale = null;

    //Eye tracking
    private MaterialProperty targetEye = null;
    private MaterialProperty maxLookRange = null;
    private MaterialProperty randTest = null;
    private MaterialProperty eyeTrackPatternTexture = null;
    private MaterialProperty eyeTrackSpeed = null;
    private MaterialProperty eyeTrackBlur = null;
    private MaterialProperty eyeTrackBlenderCorrection = null;

    //Matcap
    private MaterialProperty matcapMode = null;
    private MaterialProperty matcapTexture = null;
    private MaterialProperty matcapStrength = null;

    //Overlay stuff
    private MaterialProperty overlayMode = null;
    private MaterialProperty overlayStrength = null;
    private MaterialProperty panoCubeCrossfade = null;
    //Pano
    private MaterialProperty panosphereEnabled = null;
    private MaterialProperty panoTex = null;
    private MaterialProperty panoRotationSpeedX = null;
    private MaterialProperty panoRotationSpeedY = null;
    //Cubemap
    private MaterialProperty cubemapEnabled = null;
    private MaterialProperty cubemapTex = null;
    private MaterialProperty cubemapInitialRotation = null;
    private MaterialProperty cubemapRotationSpeed = null;

    //Rimlight
    private MaterialProperty rimlightMode = null;
    private MaterialProperty rimColorTint = null;
    private MaterialProperty rimTexture = null;
    private MaterialProperty rimWidth = null;
    private MaterialProperty rimInvert = null;

    //Shadows
    private MaterialProperty receiveShadows = null;

    private MaterialEditor editor;

    private Material material;

    // Keeps track of which sections are opened and closed.
    private bool mainExpanded = true;
    private bool toonExpanded = true;
    private bool outlinesExpanded = false;
    private bool metallicExpanded = false;
    private bool vertexOffsetExpanded = false;
    private bool eyeTrackingExpanded = false;
    private bool matcapExpanded = false;
    private bool rimlightExpanded = false;
    private bool overlayExpanded = false;
    private bool miscExpanded = false;

    private const float kMaxfp16 = 65536f; // Clamp to a value that fits into fp16.
    private float defaultLabelWidth;
    private float defaultFieldWidth;

    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
    {
        FindProperties(properties);
        this.editor = materialEditor;

        material = materialEditor.target as Material;

        defaultLabelWidth = EditorGUIUtility.labelWidth;
        defaultFieldWidth = EditorGUIUtility.fieldWidth;

        // Some properties like rendering mode may be out of range when switching from another shader. This fixes that.
        SetupDefaults();

        DrawMain();
        DrawToonLighting();
        if(HasOutlines())
        {
            DrawOutlines();
        }
        DrawMetallic();
        if(HasVertexOffset())
        {
            DrawVertexOffset();
        }
        if(HasEyeTracking())
        {
            DrawEyeTracking();
        }

        DrawMatcap();
        DrawRimlight();
        DrawOverlay();
        DrawMisc();

        SetupKeywords();
    }

    public override void AssignNewShaderToMaterial(Material material, Shader oldShader, Shader newShader)
    {
        // Reset render queue and rendertype
        material.renderQueue = -1;
        material.SetOverrideTag("RenderType", "");

        // Apply the shader change
        base.AssignNewShaderToMaterial(material, oldShader, newShader);

        // Set queue back to AlphaTest if Cutout is enabled but the new shader is not transparent
        if(!newShader.name.ToUpperInvariant().Contains("TRANSPARENT") && material.GetFloat("_Mode") == 1)
        {
            material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.AlphaTest;
            material.SetOverrideTag("RenderType", "TransparentCutout");
        }
    }

    private void DrawMain()
    {
        mainExpanded = Section("Main", mainExpanded);
        if (!mainExpanded)
        {
            return;
        }

        EditorGUIUtility.labelWidth = 0f;

        editor.TexturePropertySingleLine(new GUIContent("Main Texture", "The main texture (RGBA) and color tint."), mainTex, color);
        editor.TextureScaleOffsetProperty(mainTex);

        EditorGUILayout.Space();

        editor.TexturePropertySingleLine(new GUIContent("Normal Map", "The normal map."), normalMap);
        editor.TextureScaleOffsetProperty(normalMap);

        EditorGUILayout.Space();

        editor.TexturePropertyWithHDRColor(new GUIContent("Emission", "The emission map (RGB) and HDR color tint."), emissionMap, emissionColor, false);
        editor.TextureScaleOffsetProperty(emissionMap);

        EditorGUILayout.Space();

        // Draw cutout selection. Should be a Standard-style dropdown normally, but if the shader is transparent it needs to be a checkbox.
        if(HasTransparency())
        {
            editor.ShaderProperty(cutoutMode, new GUIContent("Cutout", "Whether Alpha Cutout should be enabled."));
        }
        else
        {
            EditorGUI.showMixedValue = cutoutMode.hasMixedValue;

            EditorGUI.BeginChangeCheck();
            cutoutMode.floatValue = EditorGUILayout.Popup(new GUIContent("Render Mode", "Whether Alpha Cutout should be enabled."), (int)cutoutMode.floatValue, new string[] { "Opaque", "Cutout" });
            if (EditorGUI.EndChangeCheck())
            {
                SetupDefaultRenderQueue();
                editor.RegisterPropertyChangeUndo("Render Mode");
            }

            EditorGUI.showMixedValue = false;
        }

        // Only render cutout slider if cutout is enabled
        if (cutoutMode.floatValue == 1)
        {
            editor.RangeProperty(alphaCutoff, "Alpha Cutoff");
        }

        editor.ShaderProperty(sidedness, "Sidedness");

        if(HasTransparency())
        {
            editor.RangeProperty(opacity, "Opacity");
            editor.ShaderProperty(ZWrite, "ZWrite");
        }
    }

    private void DrawToonLighting()
    {
        toonExpanded = Section("Toon Lighting", toonExpanded);
        if (!toonExpanded)
        {
            return;
        }

        editor.VectorProperty(staticToonLight, "Static Toon Light");
        editor.RangeProperty(worldLightIntensity, "World Light Intensity");
        editor.ShaderProperty(overrideWorldLight, "Override World Light");
        editor.ShaderProperty(billboardStaticLight, "Billboard Static Light");

        //Display warning if world lighting *and* billboarding is used.
        if(overrideWorldLight.floatValue == 0 && billboardStaticLight.floatValue == 1)
        {
            EditorGUILayout.HelpBox("Billboard static lighting is only recommended to be used when overriding the world light.", MessageType.Warning);
        }

        ToonRampProperty(new GUIContent("Toon Ramp", "The toon ramp texture to use."), ramp);

        editor.RangeProperty(toonContrast, "Toon Contrast");
        editor.RangeProperty(intensity, "Intensity");
        editor.RangeProperty(saturation, "Saturation");

        editor.ShaderProperty(lightMode, new GUIContent("Lighting Mode", "The light mode to use. Legacy Toon is like older versions, will clamp overbright lighting and mostly ignore light color. PBR makes the normals matter more in light calculations."));

        if(lightMode.floatValue != 2)
        {
            editor.ShaderProperty(exposure, new GUIContent("Exposure", "Controls the contribution of directional and realtime lights."));
            editor.ShaderProperty(toonRampDimmingEnabled, new GUIContent("Toon Ramp Dimming", "If enabled, the toon ramp's intensity will decrease as the surface gets brighter."));
            if (toonRampDimmingEnabled.floatValue == 1)
            {
                editor.ShaderProperty(exposureToonRampContrast, new GUIContent("Exposure Toon Ramp Contrast", "As this value increases, the intensity of toon ramps on lighter surfaces increases."));
            }
        }

        if(HasRampMasking())
        {
            EditorGUILayout.Space();
            DrawRampMasking();
        }
    }

    private void DrawRampMasking()
    {
        GUILayout.Label("Ramp Masking", EditorStyles.boldLabel);
        editor.TexturePropertySingleLine(new GUIContent("Ramp Mask Texture", "A mask texture that dictates which toon ramp goes where (black, red, green, blue)."), rampMaskTex);
        EditorGUILayout.Space();

        //Red ramp
        ToonRampProperty(new GUIContent("Toon Ramp (R)", "The toon ramp texture to use on the red parts of the mask."), rampR);
        editor.RangeProperty(toonContrastR, "Toon Contrast (R)");
        editor.RangeProperty(intensityR, "Intensity (R)");
        editor.RangeProperty(saturationR, "Saturation (R)");

        EditorGUILayout.Space();

        //Green ramp
        ToonRampProperty(new GUIContent("Toon Ramp (G)", "The toon ramp texture to use on the green parts of the mask."), rampG);
        editor.RangeProperty(toonContrastG, "Toon Contrast (G)");
        editor.RangeProperty(intensityG, "Intensity (G)");
        editor.RangeProperty(saturationG, "Saturation (G)");

        EditorGUILayout.Space();

        //Blue ramp
        ToonRampProperty(new GUIContent("Toon Ramp (B)", "The toon ramp texture to use on the blue parts of the mask."), rampB);
        editor.RangeProperty(toonContrastB, "Toon Contrast (B)");
        editor.RangeProperty(intensityB, "Intensity (B)");
        editor.RangeProperty(saturationB, "Saturation (B)");
    }

    private void DrawOutlines()
    {
        outlinesExpanded = Section("Outlines", outlinesExpanded);
        if (!outlinesExpanded)
        {
            return;
        }

        editor.FloatProperty(outlineWidth, "Outline Width");
        editor.TexturePropertySingleLine(new GUIContent("Outline Texture", "The main texture (RGBA) and color tint used for the outlines. Alpha determines outline width."), outlineTex, outlineColor);
        editor.ShaderProperty(outlineAlphaAffectsWidth, new GUIContent("Alpha affects width", "Whether the outline texture's alpha should affect the outline width in that area."));
        editor.ShaderProperty(outlineScreenspace, new GUIContent("Screenspace outlines", "Whether the outlines should be screenspace (always equally large, no matter the distance)"));

        if (outlineScreenspace.floatValue == 1)
        {
            // Draw multi-slider for min/max distance
            float minDist = outlineScreenspaceMinDistance.floatValue;
            float maxDist = outlineScreenspaceMaxDistance.floatValue;
            EditorGUI.BeginChangeCheck();
            EditorGUILayout.MinMaxSlider("Size Limits (Min / Max)", ref minDist, ref maxDist, 0f, 10f);
            if (EditorGUI.EndChangeCheck())
            {
                outlineScreenspaceMinDistance.floatValue = minDist;
                outlineScreenspaceMaxDistance.floatValue = maxDist;
            }

            editor.FloatProperty(outlineScreenspaceMinDistance, "Min Size");
            editor.FloatProperty(outlineScreenspaceMaxDistance, "Max Size");
        }

        editor.ShaderProperty(outlineStencilComp, new GUIContent("Outline Mode", "Outer Only will only render the outlines on the outer edges of the model."));
        editor.ShaderProperty(outlineCutout, new GUIContent("Cutout Outlines", "Whether the outlines should be subject to cutout."));

        //Display a warning if the user attempts to use outlines to create double-sidedness.
        if(
            outlineWidth.floatValue == 0
            && outlineTex.textureValue != null && mainTex.textureValue != null
            && outlineTex.textureValue.GetInstanceID() == mainTex.textureValue.GetInstanceID())
        {
            EditorGUILayout.HelpBox("Outlines should not be used to make your model double-sided. Use the \"Sidedness\" property under Main instead.", MessageType.Warning);
        }
    }

    private void DrawMetallic()
    {
        metallicExpanded = Section("Metallic", metallicExpanded);
        if (!metallicExpanded)
        {
            return;
        }

        editor.ShaderProperty(metallicMode, new GUIContent("Metallic Mode", "Set the metallic mode for this material (None, Metallic workflow, Specular workflow)"));

        //Draw either the metallic or specular controls
        if(metallicMode.floatValue == 1)
        {
            DrawMetallicWorkflow();
        }
        else if(metallicMode.floatValue == 2)
        {
            DrawSpecularWorkflow();
        }
        else
        {
            //Draw greyed out metallic
            EditorGUI.BeginDisabledGroup(true);
            DrawMetallicWorkflow();
            EditorGUI.EndDisabledGroup();
        }
    }

    private void DrawMetallicWorkflow()
    {
        editor.TexturePropertySingleLine(new GUIContent("Metallic Map", "Defines Metallic (R) and Smoothness (A). Lower smoothness blurs reflections."), metallicMap);
        editor.RangeProperty(metallic, "Metallic");
        editor.RangeProperty(smoothness, "Smoothness");
    }

    private void DrawSpecularWorkflow()
    {
        editor.TexturePropertyWithHDRColor(new GUIContent("Specular Map", "Defines Specular color (RGB) and Smoothness (A). Lower smoothness blurs reflections."), specularMap, specularColor, true);
        editor.RangeProperty(smoothness, "Smoothness");
    }

    private void DrawVertexOffset()
    {
        vertexOffsetExpanded = Section("Vertex Offset", vertexOffsetExpanded);
        if (!vertexOffsetExpanded)
        {
            return;
        }

        editor.VectorProperty(vertexOffsetWorld, "World Position Offset");
        editor.VectorProperty(vertexOffset, "Local Position Offset");
        editor.VectorProperty(vertexRotation, "Rotation Offset");
        editor.VectorProperty(vertexScale, "Scale");
    }

    private void DrawEyeTracking()
    {
        eyeTrackingExpanded = Section("Eye Tracking", eyeTrackingExpanded);
        if(!eyeTrackingExpanded)
        {
            return;
        }

        editor.ShaderProperty(targetEye, "Target Eye");

        editor.RangeProperty(maxLookRange, "Maximum Look Range");

        EditorGUILayout.HelpBox("The eye tracking pattern texture should be a horizontal black and white gradient texture. It scrolls from left to right over time. When the current pixel is black, the eyes will look straight ahead. When the current pixel is white, the eyes will look straight towards the camera. In-between values are possible.", MessageType.Info);

        editor.TexturePropertySingleLine(new GUIContent("Eye Tracking Pattern Texture"), eyeTrackPatternTexture);

        editor.RangeProperty(eyeTrackSpeed, "Pattern Scroll Speed");

        editor.RangeProperty(eyeTrackBlur, "Pattern Blur");

        EditorGUILayout.HelpBox("Blender FBX exports may be rotated 90 degrees on the X axis depending on export settings. Tick/untick this box if you experience this happening to your mesh.", MessageType.Info);
        editor.ShaderProperty(eyeTrackBlenderCorrection, new GUIContent("Blender rotation correction"));
    }

    private void DrawMatcap()
    {
        matcapExpanded = Section("Matcap", matcapExpanded);
        if (!matcapExpanded)
        {
            return;
        }

        editor.ShaderProperty(matcapMode, new GUIContent("Matcap Mode"));

        EditorGUI.BeginDisabledGroup(matcapMode.floatValue == 0);
        editor.TexturePropertySingleLine(new GUIContent("Matcap Texture"), matcapTexture);

        editor.ShaderProperty(matcapStrength, new GUIContent("Matcap Strength"));

        if(matcapMode.floatValue != 0 && matcapStrength.floatValue == 0)
        {
            EditorGUILayout.HelpBox("Matcap strength is zero, consider turning Matcap mode off for performance.", MessageType.Warning);
        }
        EditorGUI.EndDisabledGroup();
    }

    private void DrawRimlight()
    {
        rimlightExpanded = Section("Rimlight", rimlightExpanded);
        if(!rimlightExpanded)
        {
            return;
        }

        editor.ShaderProperty(rimlightMode, new GUIContent("Rimlight Mode"));
        EditorGUI.BeginDisabledGroup(rimlightMode.floatValue == 0);

        editor.TexturePropertySingleLine(new GUIContent("Rimlight Texture", "The rimlight texture. RGB controls color, Alpha controls strength."), rimTexture, rimColorTint);
        editor.RangeProperty(rimWidth, "Rimlight Width");

        editor.ShaderProperty(rimInvert, new GUIContent("Invert Rimlight"));

        if(rimlightMode.floatValue != 0 && rimColorTint.colorValue.a == 0)
        {
            EditorGUILayout.HelpBox("Rimlight alpha is set to 0. Consider turning rimlights off for performance.", MessageType.Warning);
        }

        if(rimlightMode.floatValue == 1 && rimWidth.floatValue == 0)
        {
            EditorGUILayout.HelpBox("Rimlight is additive but width is set to 0. Consider turning rimlights off for performance.", MessageType.Warning);
        }

        EditorGUI.EndDisabledGroup();
    }

    private void DrawOverlay()
    {
        overlayExpanded = Section("Overlay", overlayExpanded);
        if (!overlayExpanded)
        {
            return;
        }

        editor.ShaderProperty(overlayMode, new GUIContent("Overlay Mode", "Replace will render the overlay directly. Multiply will blend the overlay with the diffuse."));

        editor.RangeProperty(overlayStrength, "Overlay Strength");

        editor.ShaderProperty(panosphereEnabled, new GUIContent("Panosphere Enabled"));
        EditorGUI.BeginDisabledGroup(panosphereEnabled.floatValue == 0);
        this.TextureProperty(panoTex, "Panosphere Texture");
        editor.RangeProperty(panoRotationSpeedX, "Pano Rotation Speed X");
        editor.RangeProperty(panoRotationSpeedY, "Pano Rotation Speed Y");
        EditorGUI.EndDisabledGroup();

        editor.ShaderProperty(cubemapEnabled, new GUIContent("Cubemap Enabled"));
        EditorGUI.BeginDisabledGroup(cubemapEnabled.floatValue == 0);
        this.TextureProperty(cubemapTex, "Cubemap Texture");
        editor.VectorProperty(cubemapInitialRotation, "Cubemap Initial Rotation");
        editor.VectorProperty(cubemapRotationSpeed, "Cubemap Rotation Speed");
        EditorGUI.EndDisabledGroup();

        // Add crossfade slider only if both are enabled
        EditorGUI.BeginDisabledGroup(panosphereEnabled.floatValue == 0 || cubemapEnabled.floatValue == 0);
        editor.RangeProperty(panoCubeCrossfade, "Panosphere/Cubemap Crossfade");
        EditorGUI.EndDisabledGroup();

        // Display warning if strength is 0.
        if(overlayStrength.floatValue == 0 && (panosphereEnabled.floatValue == 1 || cubemapEnabled.floatValue == 1))
        {
            EditorGUILayout.HelpBox("Overlay Strength is set to 0. Consider disabling the panosphere and cubemap entirely for performance.", MessageType.Warning);
        }

        // Display warning if crossfade is either 0 or 1
        if((panosphereEnabled.floatValue == 1 && cubemapEnabled.floatValue == 1) && panoCubeCrossfade.floatValue == 0)
        {
            EditorGUILayout.HelpBox("Cubemap has no influence. Consider disabling the cubemap for performance.", MessageType.Warning);
        }
        else if((panosphereEnabled.floatValue == 1 && cubemapEnabled.floatValue == 1) && panoCubeCrossfade.floatValue == 1)
        {
            EditorGUILayout.HelpBox("Panosphere has no influence. Consider disabling the panosphere for performance.", MessageType.Warning);
        }
    }

    private void DrawMisc()
    {
        miscExpanded = Section("Misc", miscExpanded);
        if (!miscExpanded)
        {
            return;
        }

        GUILayout.Label("Shadows", EditorStyles.boldLabel);
        EditorGUILayout.HelpBox("Enabling receive shadows may cause self-shadowing. This can look good, but if you don't want it, either disable Receive Shadows here, or disable Receive Shadows/Cast Shadows on your mesh renderer.", MessageType.Info);
        editor.ShaderProperty(receiveShadows, "Receive Shadows");

        editor.RenderQueueField();
    }

    /// <summary>
    /// Draws a clickable header button.
    /// </summary>
    /// <returns>A boolean indicating whether the section is currently open or not.</returns>
    private bool Section(string title, bool expanded)
    {
        // Define style for section, reuse the one from particle systems
        var style = new GUIStyle("ShurikenModuleTitle")
        {
            font = new GUIStyle(EditorStyles.label).font,
            border = new RectOffset(15, 7, 4, 4),
            fixedHeight = 22,
            contentOffset = new Vector2(20f, -2f)
        };

        var rect = GUILayoutUtility.GetRect(16f, 22f, style);
        GUI.Box(rect, title, style);

        var e = Event.current;

        var toggleRect = new Rect(rect.x + 4f, rect.y + 2f, 13f, 13f);
        if (e.type == EventType.Repaint)
        {
            EditorStyles.foldout.Draw(toggleRect, false, false, expanded, false);
        }

        // Check if the user has clicked on the header.
        // If clicked, expand or collapse the header.
        if (e.type == EventType.MouseDown && rect.Contains(e.mousePosition))
        {
            expanded = !expanded;
            e.Use();
        }

        return expanded;
    }

    /// <summary>
    /// Draws a texture property specifically meant for Toon Ramps. Can warn the user if the toon ramp texture is not set to Clamp.
    /// </summary>
    /// <param name="guiContent">A GUIContent object to use for the label.</param>
    /// <param name="rampProperty">The material property to make the texture for. Has to be a texture.</param>
    private void ToonRampProperty(GUIContent guiContent, MaterialProperty rampProperty)
    {
        editor.TexturePropertySingleLine(guiContent, rampProperty);

        //Display warning if repeat mode is not set to clamp.
        if (TextureIsNotSetToClamp(rampProperty))
        {
            EditorGUILayout.HelpBox("Toon Ramp texture wrap mode should be set to Clamp. You may experience horrific lighting artifacts otherwise.", MessageType.Warning);
        }
    }

    /// <summary>
    /// Draws a full-size texture property, but without squishing the preview.
    /// </summary>
    /// <param name="prop">The texture property to draw.</param>
    /// <param name="label">The label to give the texture property.</param>
    private void TextureProperty(MaterialProperty prop, string label)
    {
        editor.SetDefaultGUIWidths();
        editor.TextureProperty(prop, label);
        EditorGUIUtility.labelWidth = defaultLabelWidth;
        EditorGUIUtility.fieldWidth = defaultFieldWidth;
    }

    /// <summary>
    /// Obtain all properties from the material, and bind them to the fields in this object.
    /// </summary>
    /// <param name="props">A list of properties obtained from the material.</param>
    private void FindProperties(MaterialProperty[] props)
    {
        //Main stuff
        color = FindProperty("_Color", props);
        mainTex = FindProperty("_MainTex", props);
        emissionMap = FindProperty("_EmissionMap", props);
        emissionColor = FindProperty("_EmissionColor", props);
        normalMap = FindProperty("_NormalMap", props);
        cutoutMode = FindProperty("_Mode", props);
        alphaCutoff = FindProperty("_Cutoff", props);

        sidedness = FindProperty("_Cull", props, false);

        //Toon lighting
        staticToonLight = FindProperty("_StaticToonLight", props);
        worldLightIntensity = FindProperty("_WorldLightIntensity", props);
        overrideWorldLight = FindProperty("_OverrideWorldLight", props);
        billboardStaticLight = FindProperty("_BillboardStaticLight", props);
        ramp = FindProperty("_Ramp", props);
        toonContrast = FindProperty("_ToonContrast", props);
        intensity = FindProperty("_Intensity", props);
        saturation = FindProperty("_Saturation", props);
        exposure = FindProperty("_Exposure", props);
        toonRampDimmingEnabled = FindProperty("_ToonRampDimming", props);
        exposureToonRampContrast = FindProperty("_ExposureContrast", props);
        lightMode = FindProperty("_LightingMode", props);

        //Metallic
        metallicMode = FindProperty("_MetallicMode", props);
        metallicMap = FindProperty("_MetallicGlossMap", props);
        metallic = FindProperty("_Metallic", props);
        smoothness = FindProperty("_Glossiness", props);
        specularColor = FindProperty("_SpecColor", props);
        specularMap = FindProperty("_SpecGlossMap", props);

        //Ramp mask stuff
        rampMaskTex = FindProperty("_RampMaskTex", props, false);
        rampR = FindProperty("_RampR", props, false);
        toonContrastR = FindProperty("_ToonContrastR", props, false);
        intensityR = FindProperty("_IntensityR", props, false);
        saturationR = FindProperty("_SaturationR", props, false);
        rampG = FindProperty("_RampG", props, false);
        toonContrastG = FindProperty("_ToonContrastG", props, false);
        intensityG = FindProperty("_IntensityG", props, false);
        saturationG = FindProperty("_SaturationG", props, false);
        rampB = FindProperty("_RampB", props, false);
        toonContrastB = FindProperty("_ToonContrastB", props, false);
        intensityB = FindProperty("_IntensityB", props, false);
        saturationB = FindProperty("_SaturationB", props, false);

        //Transparent stuff
        opacity = FindProperty("_Opacity", props, false);
        ZWrite = FindProperty("_ZWrite", props, false);

        //Outline stuff
        outlineWidth = FindProperty("_OutlineWidth", props, false);
        outlineColor = FindProperty("_OutlineColor", props, false);
        outlineTex = FindProperty("_OutlineTex", props, false);
        outlineScreenspace = FindProperty("_ScreenSpaceOutline", props, false);
        outlineStencilComp = FindProperty("_OutlineStencilComp", props, false);
        outlineCutout = FindProperty("_OutlineCutout", props, false);
        outlineAlphaAffectsWidth = FindProperty("_OutlineAlphaWidthEnabled", props, false);
        outlineScreenspaceMinDistance = FindProperty("_ScreenSpaceMinDist", props, false);
        outlineScreenspaceMaxDistance = FindProperty("_ScreenSpaceMaxDist", props, false);

        //Vertex offset stuff
        vertexOffset = FindProperty("_VertexOffset", props, false);
        vertexOffsetWorld = FindProperty("_WorldVertexOffset", props, false);
        vertexRotation = FindProperty("_VertexRotation", props, false);
        vertexScale = FindProperty("_VertexScale", props, false);

        //Eye tracking stuff
        targetEye = FindProperty("_TargetEye", props, false);
        maxLookRange = FindProperty("_MaxLookRange", props, false);
        randTest = FindProperty("_RandTest", props, false);
        eyeTrackPatternTexture = FindProperty("_EyeTrackingPatternTex", props, false);
        eyeTrackSpeed = FindProperty("_EyeTrackingScrollSpeed", props, false);
        eyeTrackBlur = FindProperty("_EyeTrackingBlur", props, false);
        eyeTrackBlenderCorrection = FindProperty("_EyeTrackingRotationCorrection", props, false);

        //Matcap stuff
        matcapMode = FindProperty("_MatCapMode", props);
        matcapTexture = FindProperty("_MatCap", props);
        matcapStrength = FindProperty("_MatCapStrength", props);

        //Overlay stuff
        overlayMode = FindProperty("_OverlayMode", props);
        overlayStrength = FindProperty("_OverlayStrength", props);
        panoCubeCrossfade = FindProperty("_CrossfadeTileCubemap", props);

        panosphereEnabled = FindProperty("_PanoEnabled", props);
        panoTex = FindProperty("_TileOverlay", props);
        panoRotationSpeedX = FindProperty("_TileSpeedX", props);
        panoRotationSpeedY = FindProperty("_TileSpeedY", props);

        cubemapEnabled = FindProperty("_CubemapEnabled", props);
        cubemapTex = FindProperty("_CubemapOverlay", props);
        cubemapInitialRotation = FindProperty("_CubemapRotation", props);
        cubemapRotationSpeed = FindProperty("_CubemapRotationSpeed", props);

        //Rimlight stuff
        rimlightMode = FindProperty("_RimLightMode", props);
        rimColorTint = FindProperty("_RimLightColor", props);
        rimTexture = FindProperty("_RimTex", props);
        rimWidth = FindProperty("_RimWidth", props);
        rimInvert = FindProperty("_RimInvert", props);

        //Shadow stuff
        receiveShadows = FindProperty("_ReceiveShadows", props);
    }

    // The below functions can report if the current shader supports X feature or not, by looking at whether the property was found.
    // This allows the same editor to be used for all shaders.

    private bool HasRampMasking()
    {
        return rampMaskTex != null;
    }

    private bool HasOutlines()
    {
        return outlineWidth != null;
    }

    private bool HasTransparency()
    {
        return opacity != null;
    }

    private bool HasVertexOffset()
    {
        return vertexOffset != null;
    }

    private bool HasEyeTracking()
    {
        return targetEye != null;
    }

    private bool TextureIsNotSetToClamp(MaterialProperty prop)
    {
        return prop.textureValue != null && prop.textureValue.wrapMode != TextureWrapMode.Clamp;
    }

    /// <summary>
    /// Fixes invalid cutout mode after switching from Standard Fade/Transparent to this shader.
    /// </summary>
    private void SetupDefaults()
    {
        // Turn Fade and Transparent rendering modes into Opaque
        if (this.cutoutMode.floatValue != 0 && this.cutoutMode.floatValue != 1)
        {
            this.cutoutMode.floatValue = 0;
        }
    }

    /// <summary>
    /// Remove all keywords from the material and sets up any new ones if necessary.
    /// Note: keywords should be local whenever possible.
    /// </summary>
    private void SetupKeywords()
    {
        // Delete all keywords first
        material.shaderKeywords = new string[] { };

        // Add normal map keyword if used.
        if (material.GetTexture("_NormalMap"))
        {
            material.EnableKeyword("_NORMALMAP");
        }

        // Add cutout keyword if used
        if (cutoutMode.floatValue == 1)
        {
            material.EnableKeyword("_ALPHATEST_ON");
        }

        // Add Metallic or Specular keyword if used.
        if (metallicMode.floatValue == 1)
        {
            material.EnableKeyword("_METALLICGLOSSMAP");
        }
        else if(metallicMode.floatValue == 2)
        {
            material.EnableKeyword("_SPECGLOSSMAP");
        }

        // Override world light dir keyword
        if (overrideWorldLight.floatValue == 1)
        {
            material.EnableKeyword("_OVERRIDE_WORLD_LIGHT_DIR_ON");
        }

        // Receive Shadows keyword
        if (receiveShadows.floatValue == 1)
        {
            material.EnableKeyword("_SHADOW_RECEIVE_ON");
        }

        // Emission keyword
        // Emission is automatically enabled when the emission tint is set to anything other than black. Alpha is ignored for the comparison.
        Color emissionCol = emissionColor.colorValue;
        if (new Color(emissionCol.r, emissionCol.g, emissionCol.b, 1) != Color.black)
        {
            material.EnableKeyword("_EMISSION");
        }

        // Matcap keywords
        if(matcapMode.floatValue == 1)
        {
            material.EnableKeyword("_MATCAP_ADD");
        }
        else if(matcapMode.floatValue == 2)
        {
            material.EnableKeyword("_MATCAP_MULTIPLY");
        }

        // Overlay keywords
        if(panosphereEnabled.floatValue == 1)
        {
            material.EnableKeyword("_PANO_ON");
        }

        if(cubemapEnabled.floatValue == 1)
        {
            material.EnableKeyword("_CUBEMAP_ON");
        }

        // Outline alpha width keyword
        if(HasOutlines() && outlineAlphaAffectsWidth.floatValue == 1)
        {
            material.EnableKeyword("_OUTLINE_ALPHA_WIDTH_ON");
        }

        // Screenspace outline keyword
        if(HasOutlines() && outlineScreenspace.floatValue == 1)
        {
            material.EnableKeyword("_OUTLINE_SCREENSPACE");
        }

        // Rimlight keyword
        if(rimlightMode.floatValue == 1)
        {
            material.EnableKeyword("_RIMLIGHT_ADD");
        }
        else if(rimlightMode.floatValue == 2)
        {
            material.EnableKeyword("_RIMLIGHT_MIX");
        }

        // Lighting mode
        if (lightMode.floatValue == 1)
        {
            material.EnableKeyword("_LIGHTING_PBR_ON");
        }
        else if(lightMode.floatValue == 2)
        {
            material.EnableKeyword("_LIGHTING_LEGACY_ON");
        }

        // Toon ramp dimming
        if(lightMode.floatValue != 2 && toonRampDimmingEnabled.floatValue == 1)
        {
            material.EnableKeyword("_TOON_RAMP_DIMMING");
        }
    }

    /// <summary>
    /// Set up the right default render queue and associated rendertype for the shader. 2000 for opaque, 2450 for cutout, 3000 for transparent.
    /// </summary>
    private void SetupDefaultRenderQueue()
    {
        if (!this.HasTransparency() && this.cutoutMode.floatValue == 1)
        {
            material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.AlphaTest;
            material.SetOverrideTag("RenderType", "TransparentCutout");
        }
        else
        {
            material.renderQueue = -1;
            material.SetOverrideTag("RenderType", "");
        }
    }
}