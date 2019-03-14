// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:QQB1AHQAbwBMAGkAZwBoAHQA,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:True,hqlp:False,rprd:True,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:False,igpj:False,qofs:0,qpre:0,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:34020,y:32577,varname:node_3138,prsc:2|custl-2692-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:32675,y:32222,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_7241,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Tex2d,id:1689,x:32193,y:31108,ptovrint:False,ptlb:Tile Overlay,ptin:_TileOverlay,varname:node_1689,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-6429-OUT;n:type:ShaderForge.SFN_Multiply,id:7815,x:32675,y:32080,varname:node_7815,prsc:2|A-2218-OUT,B-7241-RGB;n:type:ShaderForge.SFN_Desaturate,id:5160,x:33273,y:32044,varname:node_5160,prsc:2|COL-2316-OUT,DES-3971-OUT;n:type:ShaderForge.SFN_Vector1,id:3971,x:33273,y:32165,varname:node_3971,prsc:2,v1:-0.5;n:type:ShaderForge.SFN_Desaturate,id:9411,x:33476,y:32044,varname:node_9411,prsc:2|COL-5160-OUT,DES-8933-OUT;n:type:ShaderForge.SFN_OneMinus,id:8933,x:33476,y:31903,varname:node_8933,prsc:2|IN-8329-OUT;n:type:ShaderForge.SFN_ComponentMask,id:4810,x:29168,y:30931,varname:node_4810,prsc:2,cc1:2,cc2:0,cc3:1,cc4:-1|IN-8642-OUT;n:type:ShaderForge.SFN_Pi,id:2632,x:29201,y:31069,varname:node_2632,prsc:2;n:type:ShaderForge.SFN_Negate,id:3403,x:29339,y:31069,varname:node_3403,prsc:2|IN-2632-OUT;n:type:ShaderForge.SFN_ArcCos,id:1044,x:29339,y:30941,varname:node_1044,prsc:2|IN-4810-B;n:type:ShaderForge.SFN_Divide,id:1808,x:29515,y:31079,varname:node_1808,prsc:2|A-1044-OUT,B-3403-OUT;n:type:ShaderForge.SFN_ArcTan2,id:5315,x:29339,y:30793,varname:node_5315,prsc:2,attp:2|A-4810-R,B-4810-G;n:type:ShaderForge.SFN_Append,id:6711,x:29515,y:30941,varname:node_6711,prsc:2|A-5315-OUT,B-1808-OUT;n:type:ShaderForge.SFN_OneMinus,id:9020,x:29689,y:30941,varname:node_9020,prsc:2|IN-6711-OUT;n:type:ShaderForge.SFN_ComponentMask,id:4903,x:29689,y:31079,varname:node_4903,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-9020-OUT;n:type:ShaderForge.SFN_Append,id:1986,x:29927,y:31909,varname:node_1986,prsc:2|A-4097-OUT,B-3842-OUT;n:type:ShaderForge.SFN_Time,id:47,x:29927,y:32103,varname:node_47,prsc:2;n:type:ShaderForge.SFN_Multiply,id:7401,x:30108,y:31964,varname:node_7401,prsc:2|A-1986-OUT,B-47-T;n:type:ShaderForge.SFN_Add,id:1431,x:30108,y:32103,varname:node_1431,prsc:2|A-7401-OUT,B-9835-OUT;n:type:ShaderForge.SFN_Slider,id:2514,x:29770,y:31738,ptovrint:False,ptlb:Tile Speed X,ptin:_TileSpeedX,varname:node_2514,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-1,cur:0,max:1;n:type:ShaderForge.SFN_Multiply,id:4097,x:30108,y:31674,varname:node_4097,prsc:2|A-9795-OUT,B-2514-OUT;n:type:ShaderForge.SFN_Vector1,id:9795,x:29927,y:31674,varname:node_9795,prsc:2,v1:0.1;n:type:ShaderForge.SFN_Multiply,id:3842,x:30108,y:31814,varname:node_3842,prsc:2|A-9795-OUT,B-5322-OUT;n:type:ShaderForge.SFN_Slider,id:5322,x:29770,y:31819,ptovrint:False,ptlb:Tile Speed Y,ptin:_TileSpeedY,varname:node_5322,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-1,cur:0,max:1;n:type:ShaderForge.SFN_ComponentMask,id:769,x:29931,y:32342,varname:node_769,prsc:2,cc1:0,cc2:1,cc3:2,cc4:-1|IN-6606-OUT;n:type:ShaderForge.SFN_Multiply,id:5696,x:29931,y:32477,varname:node_5696,prsc:2|A-769-G,B-41-OUT;n:type:ShaderForge.SFN_Vector1,id:41,x:29771,y:32499,varname:node_41,prsc:2,v1:-1;n:type:ShaderForge.SFN_Append,id:7373,x:30106,y:32352,varname:node_7373,prsc:2|A-769-R,B-5696-OUT,C-769-B;n:type:ShaderForge.SFN_Cubemap,id:1516,x:32193,y:30890,ptovrint:False,ptlb:Cubemap Overlay,ptin:_CubemapOverlay,varname:node_7018,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,pvfc:0|DIR-311-OUT;n:type:ShaderForge.SFN_Multiply,id:1401,x:33002,y:30939,varname:node_1401,prsc:2|A-5595-OUT,B-8561-OUT;n:type:ShaderForge.SFN_Lerp,id:5595,x:32830,y:30939,varname:node_5595,prsc:2|A-6078-OUT,B-4914-OUT,T-9751-OUT;n:type:ShaderForge.SFN_Vector1,id:6078,x:32664,y:31057,varname:node_6078,prsc:2,v1:1;n:type:ShaderForge.SFN_Lerp,id:8561,x:33002,y:31111,varname:node_8561,prsc:2|A-6078-OUT,B-1689-RGB,T-7789-OUT;n:type:ShaderForge.SFN_Clamp01,id:9751,x:32664,y:30939,varname:node_9751,prsc:2|IN-640-OUT;n:type:ShaderForge.SFN_OneMinus,id:3312,x:32513,y:31111,varname:node_3312,prsc:2|IN-640-OUT;n:type:ShaderForge.SFN_Add,id:7321,x:32664,y:31111,varname:node_7321,prsc:2|A-6078-OUT,B-3312-OUT;n:type:ShaderForge.SFN_Clamp01,id:7789,x:32819,y:31111,varname:node_7789,prsc:2|IN-7321-OUT;n:type:ShaderForge.SFN_Slider,id:6331,x:30882,y:30976,ptovrint:False,ptlb:Crossfade Tile / Cubemap,ptin:_CrossfadeTileCubemap,varname:_CrossfadeSurfaceOverlay_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:2;n:type:ShaderForge.SFN_Multiply,id:4914,x:32358,y:30890,varname:node_4914,prsc:2|A-1516-RGB,B-9128-OUT;n:type:ShaderForge.SFN_Vector1,id:9128,x:32193,y:30824,varname:node_9128,prsc:2,v1:1;n:type:ShaderForge.SFN_Multiply,id:2692,x:33352,y:32731,varname:node_2692,prsc:2|A-4067-OUT,B-1014-OUT,C-5812-OUT;n:type:ShaderForge.SFN_Slider,id:4067,x:32881,y:32681,ptovrint:False,ptlb:Intensity,ptin:_Intensity,varname:node_1700,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.8,max:10;n:type:ShaderForge.SFN_Vector1,id:3734,x:30669,y:33128,varname:node_3734,prsc:2,v1:1;n:type:ShaderForge.SFN_Slider,id:8329,x:33116,y:31918,ptovrint:False,ptlb:Saturation,ptin:_Saturation,varname:node_8329,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.65,max:1;n:type:ShaderForge.SFN_Code,id:557,x:30283,y:32374,varname:node_557,prsc:2,code:QQBuAGcAWAAgAD0AIAByAGEAZABpAGEAbgBzACgAQQBuAGcAWAApADsACgBBAG4AZwBZACAAPQAgAHIAYQBkAGkAYQBuAHMAKABBAG4AZwBZACkAOwAKAEEAbgBnAFoAIAA9ACAAcgBhAGQAaQBhAG4AcwAoAEEAbgBnAFoAKQA7AAoACgBmAGwAbwBhAHQAMwB4ADMAIAByAG8AdABhAHQAaQBvAG4AWAAgAD0AewBmAGwAbwBhAHQAMwAoADEALgAwACwAMAAuADAALAAwAC4AMAApACwADQAKACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAZgBsAG8AYQB0ADMAKAAwAC4AMAAsAGMAbwBzACgAQQBuAGcAWAApACwALQBzAGkAbgAoAEEAbgBnAFgAKQApACwADQAKACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAZgBsAG8AYQB0ADMAKAAwAC4AMAAsAHMAaQBuACgAQQBuAGcAWAApACwAYwBvAHMAKABBAG4AZwBYACkAKQB9ADsACgBmAGwAbwBhAHQAMwAgAFYAYQBsACAAPQAgAG0AdQBsACgARABpAHIALAAgAHIAbwB0AGEAdABpAG8AbgBYACkAOwAKAAoAZgBsAG8AYQB0ADMAeAAzACAAcgBvAHQAYQB0AGkAbwBuAFkAIAA9AHsAZgBsAG8AYQB0ADMAKABjAG8AcwAoAEEAbgBnAFkAKQAsADAALgAwACwAcwBpAG4AKABBAG4AZwBZACkAKQAsAA0ACgAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgAGYAbABvAGEAdAAzACgAMAAuADAALAAxAC4AMAAsADAALgAwACkALAANAAoAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIABmAGwAbwBhAHQAMwAoAC0AcwBpAG4AKABBAG4AZwBZACkALAAwAC4AMAAsAGMAbwBzACgAQQBuAGcAWQApACkAfQA7AAoAVgBhAGwAIAA9ACAAbQB1AGwAKABWAGEAbAAsACAAcgBvAHQAYQB0AGkAbwBuAFkAKQA7AAoACgBmAGwAbwBhAHQAMwB4ADMAIAByAG8AdABhAHQAaQBvAG4AWgAgAD0AewBmAGwAbwBhAHQAMwAoAGMAbwBzACgAQQBuAGcAWgApACwALQBzAGkAbgAoAEEAbgBnAFoAKQAsADAALgAwACkALAANAAoAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIABmAGwAbwBhAHQAMwAoAHMAaQBuACgAQQBuAGcAWgApACwAYwBvAHMAKABBAG4AZwBaACkALAAwAC4AMAApACwADQAKACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAZgBsAG8AYQB0ADMAKAAwAC4AMAAsADAALgAwACwAMQAuADAAKQB9ADsACgBWAGEAbAAgAD0AIABtAHUAbAAoAFYAYQBsACwAIAByAG8AdABhAHQAaQBvAG4AWgApADsACgAKAHIAZQB0AHUAcgBuACAAVgBhAGwAOwA=,output:2,fname:CubemapRotator,width:474,height:310,input:2,input:0,input:0,input:0,input_1_label:Dir,input_2_label:AngX,input_3_label:AngY,input_4_label:AngZ|A-7373-OUT,B-5198-R,C-5198-G,D-5198-B;n:type:ShaderForge.SFN_Vector4Property,id:7906,x:29931,y:32607,ptovrint:False,ptlb:Cubemap Rotation Speed,ptin:_CubemapRotationSpeed,varname:node_7906,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0,v2:0,v3:0,v4:0;n:type:ShaderForge.SFN_Multiply,id:9458,x:30106,y:32477,varname:node_9458,prsc:2|A-7906-XYZ,B-47-T;n:type:ShaderForge.SFN_ComponentMask,id:5198,x:30106,y:32607,varname:node_5198,prsc:2,cc1:0,cc2:1,cc3:2,cc4:-1|IN-9458-OUT;n:type:ShaderForge.SFN_Set,id:6574,x:28506,y:32094,varname:VRDirection,prsc:2|IN-9929-OUT;n:type:ShaderForge.SFN_Get,id:6606,x:29750,y:32342,varname:node_6606,prsc:2|IN-6574-OUT;n:type:ShaderForge.SFN_Get,id:8642,x:29147,y:30877,varname:node_8642,prsc:2|IN-6574-OUT;n:type:ShaderForge.SFN_Set,id:4115,x:29668,y:31218,varname:ViewDirUVs,prsc:2|IN-4903-OUT;n:type:ShaderForge.SFN_Get,id:9835,x:29906,y:32056,varname:node_9835,prsc:2|IN-4115-OUT;n:type:ShaderForge.SFN_Set,id:7430,x:30108,y:32227,varname:TileUVs,prsc:2|IN-1431-OUT;n:type:ShaderForge.SFN_Get,id:6429,x:32021,y:31108,varname:node_6429,prsc:2|IN-7430-OUT;n:type:ShaderForge.SFN_Set,id:3826,x:30637,y:32694,varname:RotatedCubemapDirection,prsc:2|IN-557-OUT;n:type:ShaderForge.SFN_Get,id:311,x:32017,y:30890,varname:node_311,prsc:2|IN-3826-OUT;n:type:ShaderForge.SFN_Set,id:7634,x:30669,y:33058,varname:StaticToonLighting,prsc:2|IN-3734-OUT;n:type:ShaderForge.SFN_Set,id:5221,x:30951,y:33317,varname:DynamicToonLighting,prsc:2|IN-3734-OUT;n:type:ShaderForge.SFN_Set,id:2562,x:32372,y:33776,varname:FlatLighting,prsc:2|IN-2617-OUT;n:type:ShaderForge.SFN_Get,id:1014,x:33017,y:32749,varname:node_1014,prsc:2|IN-2562-OUT;n:type:ShaderForge.SFN_Set,id:8070,x:31018,y:31042,varname:OverlayCrossfade,prsc:2|IN-6331-OUT;n:type:ShaderForge.SFN_Get,id:640,x:32337,y:31042,varname:node_640,prsc:2|IN-8070-OUT;n:type:ShaderForge.SFN_Set,id:621,x:32981,y:30886,varname:Overlay,prsc:2|IN-1401-OUT;n:type:ShaderForge.SFN_Get,id:2218,x:32459,y:32080,varname:node_2218,prsc:2|IN-621-OUT;n:type:ShaderForge.SFN_Set,id:1181,x:32654,y:32363,varname:MappedTexture,prsc:2|IN-7815-OUT;n:type:ShaderForge.SFN_Get,id:2316,x:33252,y:31983,varname:node_2316,prsc:2|IN-1181-OUT;n:type:ShaderForge.SFN_Set,id:5816,x:33455,y:32167,varname:Diffuse,prsc:2|IN-9411-OUT;n:type:ShaderForge.SFN_Get,id:5812,x:33017,y:32804,varname:node_5812,prsc:2|IN-5816-OUT;n:type:ShaderForge.SFN_Vector1,id:2617,x:32372,y:33826,varname:node_2617,prsc:2,v1:1;n:type:ShaderForge.SFN_ViewVector,id:9929,x:28345,y:32094,varname:node_9929,prsc:2;n:type:ShaderForge.SFN_Abs,id:3038,x:-295,y:47175,varname:node_3038,prsc:2;n:type:ShaderForge.SFN_Color,id:6595,x:-337,y:47212,ptovrint:False,ptlb:node_6595,ptin:_node_6595,varname:node_6595,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;proporder:7241-1689-2514-5322-1516-7906-6331-4067-8329;pass:END;sub:END;*/

Shader "NoeNoe/NoeNoe Overlay Shader/Misc/NoeNoe Skybox" {
    Properties {
        _Color ("Color", Color) = (1,1,1,1)
        _TileOverlay ("Tile Overlay", 2D) = "white" {}
        _TileSpeedX ("Tile Speed X", Range(-1, 1)) = 0
        _TileSpeedY ("Tile Speed Y", Range(-1, 1)) = 0
        _CubemapOverlay ("Cubemap Overlay", Cube) = "_Skybox" {}
        _CubemapRotationSpeed ("Cubemap Rotation Speed", Vector) = (0,0,0,0)
        _CrossfadeTileCubemap ("Crossfade Tile / Cubemap", Range(0, 2)) = 0
        _Intensity ("Intensity", Range(0, 10)) = 0.8
        _Saturation ("Saturation", Range(0, 1)) = 0.65
    }
    SubShader {
        Tags {
            "Queue"="Background"
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _TileOverlay; uniform float4 _TileOverlay_ST;
            uniform float _TileSpeedX;
            uniform float _TileSpeedY;
            uniform samplerCUBE _CubemapOverlay;
            uniform float _CrossfadeTileCubemap;
            uniform float _Intensity;
            uniform float _Saturation;
            float3 CubemapRotator( float3 Dir , float AngX , float AngY , float AngZ ){
            AngX = radians(AngX);
            AngY = radians(AngY);
            AngZ = radians(AngZ);
            
            float3x3 rotationX ={float3(1.0,0.0,0.0),
                                        float3(0.0,cos(AngX),-sin(AngX)),
                                        float3(0.0,sin(AngX),cos(AngX))};
            float3 Val = mul(Dir, rotationX);
            
            float3x3 rotationY ={float3(cos(AngY),0.0,sin(AngY)),
                                        float3(0.0,1.0,0.0),
                                        float3(-sin(AngY),0.0,cos(AngY))};
            Val = mul(Val, rotationY);
            
            float3x3 rotationZ ={float3(cos(AngZ),-sin(AngZ),0.0),
                                        float3(sin(AngZ),cos(AngZ),0.0),
                                        float3(0.0,0.0,1.0)};
            Val = mul(Val, rotationZ);
            
            return Val;
            }
            
            uniform float4 _CubemapRotationSpeed;
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
////// Lighting:
                float FlatLighting = 1.0;
                float node_6078 = 1.0;
                float3 VRDirection = viewDirection;
                float3 node_769 = VRDirection.rgb;
                float4 node_47 = _Time;
                float3 node_5198 = (_CubemapRotationSpeed.rgb*node_47.g).rgb;
                float3 RotatedCubemapDirection = CubemapRotator( float3(node_769.r,(node_769.g*(-1.0)),node_769.b) , node_5198.r , node_5198.g , node_5198.b );
                float OverlayCrossfade = _CrossfadeTileCubemap;
                float node_640 = OverlayCrossfade;
                float node_9795 = 0.1;
                float3 node_4810 = VRDirection.brg;
                float2 ViewDirUVs = (1.0 - float2(((atan2(node_4810.r,node_4810.g)/6.28318530718)+0.5),(acos(node_4810.b)/(-1*3.141592654)))).rg;
                float2 TileUVs = ((float2((node_9795*_TileSpeedX),(node_9795*_TileSpeedY))*node_47.g)+ViewDirUVs);
                float2 node_6429 = TileUVs;
                float4 _TileOverlay_var = tex2D(_TileOverlay,TRANSFORM_TEX(node_6429, _TileOverlay));
                float3 Overlay = (lerp(float3(node_6078,node_6078,node_6078),(texCUBE(_CubemapOverlay,RotatedCubemapDirection).rgb*1.0),saturate(node_640))*lerp(float3(node_6078,node_6078,node_6078),_TileOverlay_var.rgb,saturate((node_6078+(1.0 - node_640)))));
                float3 MappedTexture = (Overlay*_Color.rgb);
                float3 Diffuse = lerp(lerp(MappedTexture,dot(MappedTexture,float3(0.3,0.59,0.11)),(-0.5)),dot(lerp(MappedTexture,dot(MappedTexture,float3(0.3,0.59,0.11)),(-0.5)),float3(0.3,0.59,0.11)),(1.0 - _Saturation));
                float3 finalColor = (_Intensity*FlatLighting*Diffuse);
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
