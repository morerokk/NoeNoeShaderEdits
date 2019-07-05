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

    //Toon lighting
    private MaterialProperty staticToonLight = null;
    private MaterialProperty worldLightIntensity = null;
    private MaterialProperty overrideWorldLight = null;
    private MaterialProperty billboardStaticLight = null;
    private MaterialProperty ramp = null;
    private MaterialProperty toonContrast = null;
    private MaterialProperty intensity = null;
    private MaterialProperty saturation = null;

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

    //Vertex offset stuff
    private MaterialProperty vertexOffset = null;
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

    //Shadows
    private MaterialProperty receiveShadows = null;

    private MaterialEditor editor;

    private Material material;

    private bool mainExpanded = true;
    private bool toonExpanded = true;
    private bool outlinesExpanded = false;
    private bool metallicExpanded = false;
    private bool vertexOffsetExpanded = false;
    private bool eyeTrackingExpanded = false;
    private bool matcapExpanded = false;
    private bool miscExpanded = false;

    private const float kMaxfp16 = 65536f; // Clamp to a value that fits into fp16.

    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
    {
        FindProperties(properties);
        this.editor = materialEditor;

        material = materialEditor.target as Material;

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
        DrawMisc();

        SetupKeywords();
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

        editor.RangeProperty(alphaCutoff, "Alpha Cutoff");

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
        editor.ShaderProperty(outlineScreenspace, new GUIContent("Screenspace outlines", "Whether the outlines should be screenspace (always equally large, no matter the distance)"));
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
        editor.TexturePropertyWithHDRColor(new GUIContent("Specular Map", "Defines Specular color (RGB) and Smoothness (A). Lower smoothness blurs reflections."), specularMap, specularColor, false);
        editor.RangeProperty(smoothness, "Smoothness");
    }

    private void DrawVertexOffset()
    {
        vertexOffsetExpanded = Section("Vertex Offset", vertexOffsetExpanded);
        if (!vertexOffsetExpanded)
        {
            return;
        }

        editor.VectorProperty(vertexOffset, "Position Offset");
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

        editor.ShaderProperty(matcapStrength, new GUIContent("Matcap strength"));

        if(matcapMode.floatValue != 0 && matcapStrength.floatValue == 0)
        {
            EditorGUILayout.HelpBox("Matcap strength is zero, consider turning Matcap mode off for performance.", MessageType.Warning);
        }
        EditorGUI.EndDisabledGroup();
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
    }

    /// <summary>
    /// Draws a clickable header button.
    /// </summary>
    /// <returns>A boolean indicating whether the section is currently open or not.</returns>
    private bool Section(string title, bool expanded)
    {
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

        if (e.type == EventType.MouseDown && rect.Contains(e.mousePosition))
        {
            expanded = !expanded;
            e.Use();
        }

        return expanded;
    }

    private void ToonRampProperty(GUIContent guiContent, MaterialProperty rampProperty)
    {
        editor.TexturePropertySingleLine(guiContent, rampProperty);

        //Display warning if repeat mode is not set to clamp.
        if (TextureIsNotSetToClamp(rampProperty))
        {
            EditorGUILayout.HelpBox("Toon Ramp texture wrap mode should be set to Clamp. You may experience horrific lighting artifacts otherwise.", MessageType.Warning);
        }
    }

    private void FindProperties(MaterialProperty[] props)
    {
        //Main stuff
        color = FindProperty("_Color", props);
        mainTex = FindProperty("_MainTex", props);
        emissionMap = FindProperty("_EmissionMap", props);
        emissionColor = FindProperty("_EmissionColor", props);
        normalMap = FindProperty("_NormalMap", props);
        alphaCutoff = FindProperty("_Cutoff", props);

        sidedness = FindProperty("_Cull", props, false);

        //Toon lighting
        staticToonLight = FindProperty("_StaticToonLight", props);
        worldLightIntensity = FindProperty("_WorldLightIntensity", props);
        overrideWorldLight = FindProperty("_OverrideWorldLight", props);
        billboardStaticLight = FindProperty("_BillboardStaticLight", props);
        ramp = FindProperty("_RealRamp", props);
        toonContrast = FindProperty("_ToonContrast", props);
        intensity = FindProperty("_Intensity", props);
        saturation = FindProperty("_Saturation", props);

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

        //Vertex offset stuff
        vertexOffset = FindProperty("_VertexOffset", props, false);
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

        //Shadow stuff
        receiveShadows = FindProperty("_ReceiveShadows", props);
    }

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

    private void SetupKeywords()
    {
        // Delete all keywords first
        material.shaderKeywords = new string[] { };

        // Add normal map keyword if used.
        if (material.GetTexture("_NormalMap"))
        {
            material.EnableKeyword("_NORMALMAP");
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

        // Emission keyword, alpha is ignored.
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
    }
}