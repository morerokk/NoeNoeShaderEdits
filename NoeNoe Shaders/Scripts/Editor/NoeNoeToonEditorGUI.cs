using UnityEditor;
using UnityEngine;

public class NoeNoeToonEditorGUI : ShaderGUI
{
    private MaterialProperty color = null;
    private MaterialProperty mainTex = null;
    private MaterialProperty staticToonLight = null;
    private MaterialProperty worldLightIntensity = null;
    private MaterialProperty overrideWorldLight = null;
    private MaterialProperty billboardStaticLight = null;
    private MaterialProperty ramp = null;
    private MaterialProperty toonContrast = null;
    private MaterialProperty emissionMap = null;
    private MaterialProperty emission = null;
    private MaterialProperty intensity = null;
    private MaterialProperty saturation = null;
    private MaterialProperty normalMap = null;
    private MaterialProperty alphaCutoff = null;
    private MaterialProperty sidedness = null;
    private MaterialProperty metallicMap = null;
    private MaterialProperty metallic = null;
    private MaterialProperty smoothness = null;
    private MaterialProperty fallbackRamp = null;

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

    private MaterialEditor editor;

    private Material material;

    private bool mainExpanded = true;
    private bool toonExpanded = true;
    private bool outlinesExpanded = false;
    private bool metallicExpanded = false;
    private bool vertexOffsetExpanded = false;
    private bool fallbackExpanded = false;

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
        DrawFallback();

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

        editor.TexturePropertySingleLine(new GUIContent("Emission Map", "The emission map (RGB)."), emissionMap);
        editor.TextureScaleOffsetProperty(emissionMap);
        EditorGUILayout.Space();
        editor.RangeProperty(emission, "Emission");

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

        editor.TexturePropertySingleLine(new GUIContent("Toon Ramp", "The toon ramp texture to use."), ramp);

        //Display warning if repeat mode is not set to clamp.
        if(TextureIsNotSetToClamp(ramp))
        {
            EditorGUILayout.HelpBox("Toon Ramp texture wrap mode should be set to Clamp. You may experience horrific lighting artifacts otherwise.", MessageType.Warning);
        }
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
        editor.TexturePropertySingleLine(new GUIContent("Toon Ramp (R)", "The toon ramp texture to use on the red parts of the mask."), rampR);

        if (TextureIsNotSetToClamp(rampR))
        {
            EditorGUILayout.HelpBox("Toon Ramp texture wrap mode should be set to Clamp. You may experience horrific lighting artifacts otherwise.", MessageType.Warning);
        }
        editor.RangeProperty(toonContrastR, "Toon Contrast (R)");

        editor.RangeProperty(intensityR, "Intensity (R)");
        editor.RangeProperty(saturationR, "Saturation (R)");

        EditorGUILayout.Space();

        //Green ramp
        editor.TexturePropertySingleLine(new GUIContent("Toon Ramp (G)", "The toon ramp texture to use on the green parts of the mask."), rampG);

        if (TextureIsNotSetToClamp(rampG))
        {
            EditorGUILayout.HelpBox("Toon Ramp texture wrap mode should be set to Clamp. You may experience horrific lighting artifacts otherwise.", MessageType.Warning);
        }
        editor.RangeProperty(toonContrastG, "Toon Contrast (G)");

        editor.RangeProperty(intensityG, "Intensity (G)");
        editor.RangeProperty(saturationG, "Saturation (G)");

        EditorGUILayout.Space();

        //Blue ramp
        editor.TexturePropertySingleLine(new GUIContent("Toon Ramp (B)", "The toon ramp texture to use on the red parts of the mask."), rampB);

        if (TextureIsNotSetToClamp(rampB))
        {
            EditorGUILayout.HelpBox("Toon Ramp texture wrap mode should be set to Clamp. You may experience horrific lighting artifacts otherwise.", MessageType.Warning);
        }
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

        editor.TexturePropertySingleLine(new GUIContent("Metallic Map", "Defines Metallic (R) and Smoothness (A). Lower smoothness blurs reflections."), metallicMap);
        editor.RangeProperty(metallic, "Metallic");
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

    private void DrawFallback()
    {
        fallbackExpanded = Section("Fallback", fallbackExpanded);
        if (!fallbackExpanded)
        {
            return;
        }

        EditorGUILayout.HelpBox("This fallback toon ramp is used in case your shaders are blocked. The softer toon ramp looks bad on VRChat's internal toon shader, so you can set a different fallback ramp here.", MessageType.Info);
        editor.TexturePropertySingleLine(new GUIContent("Fallback Ramp", "Fallback toon ramp. Leave on default if you don't know what you're doing."), fallbackRamp);

        if (TextureIsNotSetToClamp(fallbackRamp))
        {
            EditorGUILayout.HelpBox("Toon Ramp texture wrap mode should be set to Clamp. You may experience horrific lighting artifacts otherwise.", MessageType.Warning);
        }
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

    private void FindProperties(MaterialProperty[] props)
    {
        color = FindProperty("_Color", props);
        mainTex = FindProperty("_MainTex", props);
        staticToonLight = FindProperty("_StaticToonLight", props);
        worldLightIntensity = FindProperty("_WorldLightIntensity", props);
        overrideWorldLight = FindProperty("_OverrideWorldLight", props);
        billboardStaticLight = FindProperty("_BillboardStaticLight", props);
        ramp = FindProperty("_RealRamp", props);
        toonContrast = FindProperty("_ToonContrast", props);
        emissionMap = FindProperty("_EmissionMap", props);
        emission = FindProperty("_Emission", props);
        intensity = FindProperty("_Intensity", props);
        saturation = FindProperty("_Saturation", props);
        normalMap = FindProperty("_NormalMap", props);
        alphaCutoff = FindProperty("_Cutoff", props);
        metallicMap = FindProperty("_MetallicGlossMap", props);
        metallic = FindProperty("_Metallic", props);
        smoothness = FindProperty("_Glossiness", props);
        fallbackRamp = FindProperty("_Ramp", props);

        sidedness = FindProperty("_Cull", props, false);

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

    private bool TextureIsNotSetToClamp(MaterialProperty prop)
    {
        return prop.textureValue != null && prop.textureValue.wrapMode != TextureWrapMode.Clamp;
    }

    private void SetupKeywords()
    {
        // Delete all keywords first
        material.shaderKeywords = new string[] { };

        // Add Metallic *if* used.
        if (metallic.floatValue > 0)
        {
            material.EnableKeyword("_METALLICGLOSSMAP");
        }
    }
}