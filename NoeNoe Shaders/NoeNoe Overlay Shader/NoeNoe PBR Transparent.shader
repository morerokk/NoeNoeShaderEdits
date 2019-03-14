// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:QQB1AHQAbwBMAGkAZwBoAHQA,lico:1,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:True,hqlp:False,rprd:True,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:False,igpj:False,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:34020,y:32577,varname:node_3138,prsc:2|diff-1940-OUT,spec-7636-OUT,gloss-8349-OUT,normal-4793-RGB,emission-8664-OUT,alpha-3272-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:32675,y:32222,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_7241,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Tex2d,id:1689,x:32193,y:31108,ptovrint:False,ptlb:Tile Overlay,ptin:_TileOverlay,varname:node_1689,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-6429-OUT;n:type:ShaderForge.SFN_Tex2d,id:9151,x:32404,y:32286,ptovrint:False,ptlb:Main texture (RGB),ptin:_MainTex,varname:node_9151,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:7815,x:32675,y:32080,varname:node_7815,prsc:2|A-2845-OUT,B-7241-RGB;n:type:ShaderForge.SFN_Desaturate,id:5160,x:33273,y:32044,varname:node_5160,prsc:2|COL-2316-OUT,DES-3971-OUT;n:type:ShaderForge.SFN_Vector1,id:3971,x:33273,y:32165,varname:node_3971,prsc:2,v1:-0.5;n:type:ShaderForge.SFN_Desaturate,id:9411,x:33476,y:32044,varname:node_9411,prsc:2|COL-5160-OUT,DES-8933-OUT;n:type:ShaderForge.SFN_OneMinus,id:8933,x:33476,y:31903,varname:node_8933,prsc:2|IN-8329-OUT;n:type:ShaderForge.SFN_ComponentMask,id:4810,x:29168,y:30931,varname:node_4810,prsc:2,cc1:2,cc2:0,cc3:1,cc4:-1|IN-8642-OUT;n:type:ShaderForge.SFN_Pi,id:2632,x:29201,y:31069,varname:node_2632,prsc:2;n:type:ShaderForge.SFN_Negate,id:3403,x:29339,y:31069,varname:node_3403,prsc:2|IN-2632-OUT;n:type:ShaderForge.SFN_ArcCos,id:1044,x:29339,y:30941,varname:node_1044,prsc:2|IN-4810-B;n:type:ShaderForge.SFN_Divide,id:1808,x:29515,y:31079,varname:node_1808,prsc:2|A-1044-OUT,B-3403-OUT;n:type:ShaderForge.SFN_ArcTan2,id:5315,x:29339,y:30793,varname:node_5315,prsc:2,attp:2|A-4810-R,B-4810-G;n:type:ShaderForge.SFN_Append,id:6711,x:29515,y:30941,varname:node_6711,prsc:2|A-5315-OUT,B-1808-OUT;n:type:ShaderForge.SFN_OneMinus,id:9020,x:29689,y:30941,varname:node_9020,prsc:2|IN-6711-OUT;n:type:ShaderForge.SFN_ComponentMask,id:4903,x:29689,y:31079,varname:node_4903,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-9020-OUT;n:type:ShaderForge.SFN_Multiply,id:2845,x:32675,y:31959,varname:node_2845,prsc:2|A-3107-OUT,B-6612-OUT;n:type:ShaderForge.SFN_Lerp,id:3107,x:32404,y:31908,varname:node_3107,prsc:2|A-7920-OUT,B-2218-OUT,T-3915-OUT;n:type:ShaderForge.SFN_Vector1,id:7920,x:32404,y:32034,varname:node_7920,prsc:2,v1:1;n:type:ShaderForge.SFN_Lerp,id:6612,x:32404,y:32089,varname:node_6612,prsc:2|A-7920-OUT,B-9151-RGB,T-9036-OUT;n:type:ShaderForge.SFN_Clamp01,id:8759,x:31814,y:31934,varname:node_8759,prsc:2|IN-6611-OUT;n:type:ShaderForge.SFN_OneMinus,id:9601,x:31488,y:32098,varname:node_9601,prsc:2|IN-6611-OUT;n:type:ShaderForge.SFN_Add,id:748,x:31651,y:32098,varname:node_748,prsc:2|A-4784-OUT,B-9601-OUT;n:type:ShaderForge.SFN_Clamp01,id:6835,x:31814,y:32098,varname:node_6835,prsc:2|IN-748-OUT;n:type:ShaderForge.SFN_Slider,id:6611,x:31409,y:31933,ptovrint:False,ptlb:Crossfade Surface / Overlay,ptin:_CrossfadeSurfaceOverlay,varname:node_6611,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:2;n:type:ShaderForge.SFN_Append,id:1986,x:29927,y:31909,varname:node_1986,prsc:2|A-4097-OUT,B-3842-OUT;n:type:ShaderForge.SFN_Time,id:47,x:29927,y:32103,varname:node_47,prsc:2;n:type:ShaderForge.SFN_Multiply,id:7401,x:30108,y:31964,varname:node_7401,prsc:2|A-1986-OUT,B-47-T;n:type:ShaderForge.SFN_Add,id:1431,x:30108,y:32103,varname:node_1431,prsc:2|A-7401-OUT,B-9835-OUT;n:type:ShaderForge.SFN_Slider,id:2514,x:29770,y:31738,ptovrint:False,ptlb:Tile Speed X,ptin:_TileSpeedX,varname:node_2514,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-1,cur:0,max:1;n:type:ShaderForge.SFN_Multiply,id:4097,x:30108,y:31674,varname:node_4097,prsc:2|A-9795-OUT,B-2514-OUT;n:type:ShaderForge.SFN_Vector1,id:9795,x:29927,y:31674,varname:node_9795,prsc:2,v1:0.1;n:type:ShaderForge.SFN_Multiply,id:3842,x:30108,y:31814,varname:node_3842,prsc:2|A-9795-OUT,B-5322-OUT;n:type:ShaderForge.SFN_Slider,id:5322,x:29770,y:31819,ptovrint:False,ptlb:Tile Speed Y,ptin:_TileSpeedY,varname:node_5322,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-1,cur:0,max:1;n:type:ShaderForge.SFN_ComponentMask,id:769,x:29931,y:32342,varname:node_769,prsc:2,cc1:0,cc2:1,cc3:2,cc4:-1|IN-6606-OUT;n:type:ShaderForge.SFN_Multiply,id:5696,x:29931,y:32477,varname:node_5696,prsc:2|A-769-G,B-41-OUT;n:type:ShaderForge.SFN_Vector1,id:41,x:29771,y:32499,varname:node_41,prsc:2,v1:-1;n:type:ShaderForge.SFN_Append,id:7373,x:30106,y:32352,varname:node_7373,prsc:2|A-769-R,B-5696-OUT,C-769-B;n:type:ShaderForge.SFN_Cubemap,id:1516,x:32193,y:30890,ptovrint:False,ptlb:Cubemap Overlay,ptin:_CubemapOverlay,varname:node_7018,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,pvfc:0|DIR-311-OUT;n:type:ShaderForge.SFN_Multiply,id:1401,x:33002,y:30939,varname:node_1401,prsc:2|A-5595-OUT,B-8561-OUT;n:type:ShaderForge.SFN_Lerp,id:5595,x:32830,y:30939,varname:node_5595,prsc:2|A-6078-OUT,B-4914-OUT,T-9751-OUT;n:type:ShaderForge.SFN_Vector1,id:6078,x:32664,y:31057,varname:node_6078,prsc:2,v1:1;n:type:ShaderForge.SFN_Lerp,id:8561,x:33002,y:31111,varname:node_8561,prsc:2|A-6078-OUT,B-1689-RGB,T-7789-OUT;n:type:ShaderForge.SFN_Clamp01,id:9751,x:32664,y:30939,varname:node_9751,prsc:2|IN-640-OUT;n:type:ShaderForge.SFN_OneMinus,id:3312,x:32513,y:31111,varname:node_3312,prsc:2|IN-640-OUT;n:type:ShaderForge.SFN_Add,id:7321,x:32664,y:31111,varname:node_7321,prsc:2|A-6078-OUT,B-3312-OUT;n:type:ShaderForge.SFN_Clamp01,id:7789,x:32819,y:31111,varname:node_7789,prsc:2|IN-7321-OUT;n:type:ShaderForge.SFN_Slider,id:6331,x:30882,y:30976,ptovrint:False,ptlb:Crossfade Tile / Cubemap,ptin:_CrossfadeTileCubemap,varname:_CrossfadeSurfaceOverlay_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:2;n:type:ShaderForge.SFN_Multiply,id:4914,x:32358,y:30890,varname:node_4914,prsc:2|A-1516-RGB,B-9128-OUT;n:type:ShaderForge.SFN_Vector1,id:9128,x:32193,y:30824,varname:node_9128,prsc:2,v1:1;n:type:ShaderForge.SFN_Tex2d,id:6792,x:34730,y:32578,ptovrint:False,ptlb:Emission Map,ptin:_EmissionMap,varname:node_6792,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:1116,x:34730,y:32749,ptovrint:False,ptlb:Emission,ptin:_Emission,varname:node_1116,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:10;n:type:ShaderForge.SFN_Multiply,id:2869,x:35035,y:32722,varname:node_2869,prsc:2|A-6792-RGB,B-1116-OUT;n:type:ShaderForge.SFN_Tex2d,id:4793,x:33352,y:32488,ptovrint:False,ptlb:Normal Map,ptin:_NormalMap,varname:node_4793,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Multiply,id:2692,x:33352,y:32731,varname:node_2692,prsc:2|A-4067-OUT,B-1014-OUT,C-5812-OUT;n:type:ShaderForge.SFN_Slider,id:4067,x:32881,y:32681,ptovrint:False,ptlb:Intensity,ptin:_Intensity,varname:node_1700,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.8,max:10;n:type:ShaderForge.SFN_Vector4Property,id:4622,x:27937,y:33258,ptovrint:False,ptlb:Static Toon Light,ptin:_StaticToonLight,varname:node_8394,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0,v2:3,v3:0,v4:0;n:type:ShaderForge.SFN_Vector1,id:3734,x:30669,y:33128,varname:node_3734,prsc:2,v1:1;n:type:ShaderForge.SFN_Tex2dAsset,id:1083,x:30239,y:33127,ptovrint:False,ptlb:Ramp,ptin:_Ramp,varname:node_2423,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:3281e7d3927047d42bdf0e9d5d4501ed,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Code,id:5505,x:28073,y:30825,varname:node_5505,prsc:2,code:IwBpAGYAIABkAGUAZgBpAG4AZQBkACgAVQBTAEkATgBHAF8AUwBUAEUAUgBFAE8AXwBNAEEAVABSAEkAQwBFAFMAKQANAAoAZgBsAG8AYQB0ADMAIABsAGUAZgB0AEUAeQBlACAAPQAgAHUAbgBpAHQAeQBfAFMAdABlAHIAZQBvAFcAbwByAGwAZABTAHAAYQBjAGUAQwBhAG0AZQByAGEAUABvAHMAWwAwAF0AOwANAAoAZgBsAG8AYQB0ADMAIAByAGkAZwBoAHQARQB5AGUAIAA9ACAAdQBuAGkAdAB5AF8AUwB0AGUAcgBlAG8AVwBvAHIAbABkAFMAcABhAGMAZQBDAGEAbQBlAHIAYQBQAG8AcwBbADEAXQA7AA0ACgANAAoAZgBsAG8AYQB0ADMAIABjAGUAbgB0AGUAcgBFAHkAZQAgAD0AIABsAGUAcgBwACgAbABlAGYAdABFAHkAZQAsACAAcgBpAGcAaAB0AEUAeQBlACwAIAAwAC4ANQApADsADQAKACMAZQBuAGQAaQBmAA0ACgAjAGkAZgAgACEAZABlAGYAaQBuAGUAZAAoAFUAUwBJAE4ARwBfAFMAVABFAFIARQBPAF8ATQBBAFQAUgBJAEMARQBTACkADQAKAGYAbABvAGEAdAAzACAAYwBlAG4AdABlAHIARQB5AGUAIAA9ACAAXwBXAG8AcgBsAGQAUwBwAGEAYwBlAEMAYQBtAGUAcgBhAFAAbwBzADsADQAKACMAZQBuAGQAaQBmAAoAcgBlAHQAdQByAG4AIABjAGUAbgB0AGUAcgBFAHkAZQA7AA==,output:2,fname:VRViewPosition,width:452,height:182;n:type:ShaderForge.SFN_Code,id:7341,x:28217,y:31904,varname:node_7341,prsc:2,code:ZgBsAG8AYQB0ADMAIABoAGUAYQBkAGkAbgBnACAAPQAgAHQAYQByAGcAZQB0ACAALQAgAHAAbABhAHkAZQByADsACgBmAGwAbwBhAHQAMwAgAGQAaQBzAHQAYQBuAGMAZQAgAD0AIABsAGUAbgBnAHQAaAAoAGgAZQBhAGQAaQBuAGcAKQA7AAoAZgBsAG8AYQB0ADMAIABkAGkAcgBlAGMAdABpAG8AbgAgAD0AIABoAGUAYQBkAGkAbgBnACAALwAgAGQAaQBzAHQAYQBuAGMAZQA7AAoAcgBlAHQAdQByAG4AIAAtAGQAaQByAGUAYwB0AGkAbwBuADsA,output:2,fname:VRViewDir,width:409,height:181,input:2,input:2,input_1_label:player,input_2_label:target|A-2235-OUT,B-3721-OUT;n:type:ShaderForge.SFN_Slider,id:151,x:27501,y:31624,ptovrint:False,ptlb:Stereo Distance,ptin:_StereoDistance,varname:node_151,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-5,cur:0.5,max:5;n:type:ShaderForge.SFN_Slider,id:8329,x:33116,y:31918,ptovrint:False,ptlb:Saturation,ptin:_Saturation,varname:node_8329,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.65,max:1;n:type:ShaderForge.SFN_ComponentMask,id:1153,x:27775,y:32816,varname:node_1153,prsc:2,cc1:0,cc2:1,cc3:2,cc4:-1|IN-4774-OUT;n:type:ShaderForge.SFN_Append,id:2113,x:28572,y:32957,varname:node_2113,prsc:2|A-3851-R,B-4622-Y,C-3851-G;n:type:ShaderForge.SFN_Multiply,id:975,x:28237,y:32957,varname:node_975,prsc:2|A-7017-OUT,B-4622-Z;n:type:ShaderForge.SFN_Append,id:5903,x:27937,y:32816,varname:node_5903,prsc:2|A-1153-R,B-1153-B;n:type:ShaderForge.SFN_ComponentMask,id:3851,x:28394,y:32957,varname:node_3851,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-975-OUT;n:type:ShaderForge.SFN_Normalize,id:7017,x:28086,y:32816,varname:node_7017,prsc:2|IN-5903-OUT;n:type:ShaderForge.SFN_ToggleProperty,id:4527,x:28394,y:33248,ptovrint:False,ptlb:Billboard Static Light,ptin:_BillboardStaticLight,varname:node_4527,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False;n:type:ShaderForge.SFN_If,id:7394,x:28394,y:33344,varname:node_7394,prsc:2|A-4527-OUT,B-7833-OUT,GT-4622-XYZ,EQ-6534-OUT,LT-4622-XYZ;n:type:ShaderForge.SFN_Vector1,id:7833,x:28394,y:33295,varname:node_7833,prsc:2,v1:1;n:type:ShaderForge.SFN_Multiply,id:1752,x:27775,y:33096,varname:node_1752,prsc:2|A-7869-OUT,B-4750-OUT;n:type:ShaderForge.SFN_Add,id:6534,x:28394,y:33095,varname:node_6534,prsc:2|A-8768-OUT,B-2113-OUT;n:type:ShaderForge.SFN_ComponentMask,id:8628,x:27937,y:33096,varname:node_8628,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-1752-OUT;n:type:ShaderForge.SFN_Append,id:8768,x:28237,y:33095,varname:node_8768,prsc:2|A-8628-R,B-4622-Y,C-8628-G;n:type:ShaderForge.SFN_Negate,id:2495,x:27775,y:32957,varname:node_2495,prsc:2|IN-7930-G;n:type:ShaderForge.SFN_ComponentMask,id:7930,x:27606,y:32957,varname:node_7930,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-7017-OUT;n:type:ShaderForge.SFN_Append,id:7869,x:27937,y:32957,varname:node_7869,prsc:2|A-2495-OUT,B-7930-R;n:type:ShaderForge.SFN_Negate,id:4750,x:27606,y:33096,varname:node_4750,prsc:2|IN-4622-X;n:type:ShaderForge.SFN_FragmentPosition,id:4255,x:27409,y:31995,varname:node_4255,prsc:2;n:type:ShaderForge.SFN_Lerp,id:2235,x:28217,y:31716,varname:node_2235,prsc:2|A-7847-OUT,B-7319-XYZ,T-8168-OUT;n:type:ShaderForge.SFN_Normalize,id:6955,x:27568,y:32119,varname:node_6955,prsc:2|IN-4028-OUT;n:type:ShaderForge.SFN_Subtract,id:4028,x:27409,y:32119,varname:node_4028,prsc:2|A-4255-XYZ,B-7319-XYZ;n:type:ShaderForge.SFN_Add,id:1541,x:27725,y:32119,varname:node_1541,prsc:2|A-6955-OUT,B-7319-XYZ;n:type:ShaderForge.SFN_ViewPosition,id:7319,x:27409,y:32240,varname:node_7319,prsc:2;n:type:ShaderForge.SFN_ViewPosition,id:4229,x:27579,y:31218,varname:node_4229,prsc:2;n:type:ShaderForge.SFN_ObjectPosition,id:445,x:27579,y:31337,varname:node_445,prsc:2;n:type:ShaderForge.SFN_Distance,id:8252,x:27923,y:31351,varname:node_8252,prsc:2|A-4229-XYZ,B-445-XYZ;n:type:ShaderForge.SFN_Add,id:8168,x:27923,y:31706,varname:node_8168,prsc:2|A-4163-OUT,B-151-OUT;n:type:ShaderForge.SFN_Clamp,id:2475,x:27923,y:31469,varname:node_2475,prsc:2|IN-8252-OUT,MIN-2186-OUT,MAX-7554-OUT;n:type:ShaderForge.SFN_Vector1,id:2186,x:27579,y:31457,varname:node_2186,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:7554,x:27579,y:31554,varname:node_7554,prsc:2,v1:1.5;n:type:ShaderForge.SFN_FragmentPosition,id:8350,x:27775,y:32534,varname:node_8350,prsc:2;n:type:ShaderForge.SFN_Subtract,id:3406,x:27775,y:32664,varname:node_3406,prsc:2|A-8350-XYZ,B-8338-OUT;n:type:ShaderForge.SFN_Length,id:8063,x:27942,y:32544,varname:node_8063,prsc:2|IN-3406-OUT;n:type:ShaderForge.SFN_Divide,id:8704,x:27942,y:32664,varname:node_8704,prsc:2|A-3406-OUT,B-8063-OUT;n:type:ShaderForge.SFN_Negate,id:4774,x:28092,y:32664,varname:node_4774,prsc:2|IN-8704-OUT;n:type:ShaderForge.SFN_ToggleProperty,id:6904,x:27723,y:32021,ptovrint:False,ptlb:Use Surface Depth,ptin:_UseSurfaceDepth,varname:node_6904,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False;n:type:ShaderForge.SFN_If,id:3721,x:27904,y:32119,varname:node_3721,prsc:2|A-6904-OUT,B-3379-OUT,GT-1541-OUT,EQ-4255-XYZ,LT-1541-OUT;n:type:ShaderForge.SFN_Vector1,id:3379,x:27723,y:32070,varname:node_3379,prsc:2,v1:1;n:type:ShaderForge.SFN_If,id:4163,x:27923,y:31588,varname:node_4163,prsc:2|A-6904-OUT,B-6172-OUT,GT-2475-OUT,EQ-2186-OUT,LT-2475-OUT;n:type:ShaderForge.SFN_Vector1,id:6172,x:27579,y:31508,varname:node_6172,prsc:2,v1:1;n:type:ShaderForge.SFN_Multiply,id:3272,x:33352,y:32927,varname:node_3272,prsc:2|A-7192-OUT,B-1903-OUT,C-7807-OUT;n:type:ShaderForge.SFN_Code,id:557,x:30283,y:32374,varname:node_557,prsc:2,code:QQBuAGcAWAAgAD0AIAByAGEAZABpAGEAbgBzACgAQQBuAGcAWAApADsACgBBAG4AZwBZACAAPQAgAHIAYQBkAGkAYQBuAHMAKABBAG4AZwBZACkAOwAKAEEAbgBnAFoAIAA9ACAAcgBhAGQAaQBhAG4AcwAoAEEAbgBnAFoAKQA7AAoACgBmAGwAbwBhAHQAMwB4ADMAIAByAG8AdABhAHQAaQBvAG4AWAAgAD0AewBmAGwAbwBhAHQAMwAoADEALgAwACwAMAAuADAALAAwAC4AMAApACwADQAKACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAZgBsAG8AYQB0ADMAKAAwAC4AMAAsAGMAbwBzACgAQQBuAGcAWAApACwALQBzAGkAbgAoAEEAbgBnAFgAKQApACwADQAKACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAZgBsAG8AYQB0ADMAKAAwAC4AMAAsAHMAaQBuACgAQQBuAGcAWAApACwAYwBvAHMAKABBAG4AZwBYACkAKQB9ADsACgBmAGwAbwBhAHQAMwAgAFYAYQBsACAAPQAgAG0AdQBsACgARABpAHIALAAgAHIAbwB0AGEAdABpAG8AbgBYACkAOwAKAAoAZgBsAG8AYQB0ADMAeAAzACAAcgBvAHQAYQB0AGkAbwBuAFkAIAA9AHsAZgBsAG8AYQB0ADMAKABjAG8AcwAoAEEAbgBnAFkAKQAsADAALgAwACwAcwBpAG4AKABBAG4AZwBZACkAKQAsAA0ACgAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgAGYAbABvAGEAdAAzACgAMAAuADAALAAxAC4AMAAsADAALgAwACkALAANAAoAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIABmAGwAbwBhAHQAMwAoAC0AcwBpAG4AKABBAG4AZwBZACkALAAwAC4AMAAsAGMAbwBzACgAQQBuAGcAWQApACkAfQA7AAoAVgBhAGwAIAA9ACAAbQB1AGwAKABWAGEAbAAsACAAcgBvAHQAYQB0AGkAbwBuAFkAKQA7AAoACgBmAGwAbwBhAHQAMwB4ADMAIAByAG8AdABhAHQAaQBvAG4AWgAgAD0AewBmAGwAbwBhAHQAMwAoAGMAbwBzACgAQQBuAGcAWgApACwALQBzAGkAbgAoAEEAbgBnAFoAKQAsADAALgAwACkALAANAAoAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIABmAGwAbwBhAHQAMwAoAHMAaQBuACgAQQBuAGcAWgApACwAYwBvAHMAKABBAG4AZwBaACkALAAwAC4AMAApACwADQAKACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAZgBsAG8AYQB0ADMAKAAwAC4AMAAsADAALgAwACwAMQAuADAAKQB9ADsACgBWAGEAbAAgAD0AIABtAHUAbAAoAFYAYQBsACwAIAByAG8AdABhAHQAaQBvAG4AWgApADsACgAKAHIAZQB0AHUAcgBuACAAVgBhAGwAOwA=,output:2,fname:CubemapRotator,width:474,height:310,input:2,input:0,input:0,input:0,input_1_label:Dir,input_2_label:AngX,input_3_label:AngY,input_4_label:AngZ|A-7373-OUT,B-5198-R,C-5198-G,D-5198-B;n:type:ShaderForge.SFN_Vector4Property,id:7906,x:29931,y:32607,ptovrint:False,ptlb:Cubemap Rotation Speed,ptin:_CubemapRotationSpeed,varname:node_7906,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0,v2:0,v3:0,v4:0;n:type:ShaderForge.SFN_Multiply,id:9458,x:30106,y:32477,varname:node_9458,prsc:2|A-7906-XYZ,B-47-T;n:type:ShaderForge.SFN_ComponentMask,id:5198,x:30106,y:32607,varname:node_5198,prsc:2,cc1:0,cc2:1,cc3:2,cc4:-1|IN-9458-OUT;n:type:ShaderForge.SFN_LightVector,id:7687,x:29734,y:33275,varname:node_7687,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:9090,x:29734,y:32997,prsc:2,pt:True;n:type:ShaderForge.SFN_Dot,id:8152,x:30071,y:33275,varname:node_8152,prsc:2,dt:4|A-9090-OUT,B-7687-OUT;n:type:ShaderForge.SFN_Append,id:795,x:30236,y:33275,varname:node_795,prsc:2|A-8152-OUT,B-8152-OUT;n:type:ShaderForge.SFN_Tex2d,id:3501,x:30398,y:33275,varname:node_3501,prsc:2,tex:3281e7d3927047d42bdf0e9d5d4501ed,ntxv:0,isnm:False|UVIN-795-OUT,TEX-1083-TEX;n:type:ShaderForge.SFN_Dot,id:1617,x:30072,y:32997,varname:node_1617,prsc:2,dt:4|A-9090-OUT,B-6875-OUT;n:type:ShaderForge.SFN_Tex2d,id:9498,x:30394,y:32997,varname:node_9498,prsc:2,tex:3281e7d3927047d42bdf0e9d5d4501ed,ntxv:0,isnm:False|UVIN-8091-OUT,TEX-1083-TEX;n:type:ShaderForge.SFN_Append,id:8091,x:30239,y:32997,varname:node_8091,prsc:2|A-1617-OUT,B-1617-OUT;n:type:ShaderForge.SFN_Set,id:7363,x:28405,y:31020,varname:VRPosition,prsc:2|IN-5505-OUT;n:type:ShaderForge.SFN_Get,id:7847,x:28217,y:31664,varname:node_7847,prsc:2|IN-7363-OUT;n:type:ShaderForge.SFN_Get,id:8338,x:27563,y:32682,varname:node_8338,prsc:2|IN-7363-OUT;n:type:ShaderForge.SFN_Set,id:6574,x:28506,y:32094,varname:VRDirection,prsc:2|IN-7341-OUT;n:type:ShaderForge.SFN_Get,id:6606,x:29750,y:32342,varname:node_6606,prsc:2|IN-6574-OUT;n:type:ShaderForge.SFN_Get,id:8642,x:29147,y:30877,varname:node_8642,prsc:2|IN-6574-OUT;n:type:ShaderForge.SFN_Set,id:1720,x:28394,y:33467,varname:StaticLightDirection,prsc:2|IN-7394-OUT;n:type:ShaderForge.SFN_Get,id:6875,x:29877,y:32954,varname:node_6875,prsc:2|IN-1720-OUT;n:type:ShaderForge.SFN_Set,id:4115,x:29668,y:31218,varname:ViewDirUVs,prsc:2|IN-4903-OUT;n:type:ShaderForge.SFN_Get,id:9835,x:29906,y:32056,varname:node_9835,prsc:2|IN-4115-OUT;n:type:ShaderForge.SFN_Set,id:7430,x:30108,y:32227,varname:TileUVs,prsc:2|IN-1431-OUT;n:type:ShaderForge.SFN_Get,id:6429,x:32021,y:31108,varname:node_6429,prsc:2|IN-7430-OUT;n:type:ShaderForge.SFN_Set,id:3826,x:30637,y:32694,varname:RotatedCubemapDirection,prsc:2|IN-557-OUT;n:type:ShaderForge.SFN_Get,id:311,x:32017,y:30890,varname:node_311,prsc:2|IN-3826-OUT;n:type:ShaderForge.SFN_Set,id:7634,x:30669,y:33058,varname:StaticToonLighting,prsc:2|IN-9498-RGB;n:type:ShaderForge.SFN_Set,id:5221,x:30951,y:33317,varname:DynamicToonLighting,prsc:2|IN-5356-OUT;n:type:ShaderForge.SFN_Set,id:2562,x:32372,y:33776,varname:FlatLighting,prsc:2|IN-5911-OUT;n:type:ShaderForge.SFN_Get,id:1014,x:33017,y:32749,varname:node_1014,prsc:2|IN-2562-OUT;n:type:ShaderForge.SFN_Set,id:8934,x:32383,y:32439,varname:SurfaceAlpha,prsc:2|IN-9151-A;n:type:ShaderForge.SFN_Set,id:6535,x:32193,y:31042,varname:OverlayAlpha,prsc:2|IN-1689-A;n:type:ShaderForge.SFN_Get,id:7192,x:33017,y:32950,varname:node_7192,prsc:2|IN-8934-OUT;n:type:ShaderForge.SFN_Get,id:1903,x:33017,y:32996,varname:node_1903,prsc:2|IN-6535-OUT;n:type:ShaderForge.SFN_Set,id:8070,x:31018,y:31042,varname:OverlayCrossfade,prsc:2|IN-6331-OUT;n:type:ShaderForge.SFN_Get,id:640,x:32337,y:31042,varname:node_640,prsc:2|IN-8070-OUT;n:type:ShaderForge.SFN_Set,id:621,x:32981,y:30886,varname:Overlay,prsc:2|IN-1401-OUT;n:type:ShaderForge.SFN_Get,id:2218,x:32383,y:31815,varname:node_2218,prsc:2|IN-621-OUT;n:type:ShaderForge.SFN_Set,id:1086,x:31793,y:32050,varname:OverlayFactor,prsc:2|IN-8759-OUT;n:type:ShaderForge.SFN_Get,id:3915,x:32383,y:31861,varname:node_3915,prsc:2|IN-1086-OUT;n:type:ShaderForge.SFN_Set,id:8197,x:31803,y:32218,varname:SurfaceFactor,prsc:2|IN-6835-OUT;n:type:ShaderForge.SFN_Vector1,id:4784,x:31488,y:32216,varname:node_4784,prsc:2,v1:1;n:type:ShaderForge.SFN_Get,id:9036,x:32383,y:32210,varname:node_9036,prsc:2|IN-8197-OUT;n:type:ShaderForge.SFN_Set,id:1181,x:32654,y:32363,varname:MappedTexture,prsc:2|IN-7815-OUT;n:type:ShaderForge.SFN_Get,id:2316,x:33252,y:31983,varname:node_2316,prsc:2|IN-1181-OUT;n:type:ShaderForge.SFN_Set,id:5816,x:33455,y:32167,varname:Diffuse,prsc:2|IN-9411-OUT;n:type:ShaderForge.SFN_Get,id:5812,x:33017,y:32906,varname:node_5812,prsc:2|IN-5816-OUT;n:type:ShaderForge.SFN_Set,id:6721,x:35014,y:32668,varname:MappedEmissive,prsc:2|IN-2869-OUT;n:type:ShaderForge.SFN_Get,id:8664,x:33331,y:32655,varname:node_8664,prsc:2|IN-6721-OUT;n:type:ShaderForge.SFN_Get,id:3893,x:32609,y:32793,varname:node_3893,prsc:2|IN-7634-OUT;n:type:ShaderForge.SFN_Get,id:2790,x:32609,y:32842,varname:node_2790,prsc:2|IN-5221-OUT;n:type:ShaderForge.SFN_Multiply,id:2778,x:32788,y:32793,varname:node_2778,prsc:2|A-3893-OUT,B-2790-OUT;n:type:ShaderForge.SFN_Slider,id:3269,x:32631,y:32929,ptovrint:False,ptlb:Toon Contrast,ptin:_ToonContrast,varname:node_3269,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.25,max:1;n:type:ShaderForge.SFN_Lerp,id:9693,x:33038,y:32793,varname:node_9693,prsc:2|A-424-OUT,B-2778-OUT,T-3269-OUT;n:type:ShaderForge.SFN_Vector1,id:424,x:32788,y:32749,varname:node_424,prsc:2,v1:0.5;n:type:ShaderForge.SFN_ToggleProperty,id:1360,x:30669,y:33201,ptovrint:False,ptlb:Dynamic Toon Lighting,ptin:_DynamicToonLighting,varname:node_1360,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False;n:type:ShaderForge.SFN_If,id:5356,x:30972,y:33371,varname:node_5356,prsc:2|A-1360-OUT,B-3734-OUT,GT-3734-OUT,EQ-3501-RGB,LT-3734-OUT;n:type:ShaderForge.SFN_Blend,id:1940,x:33528,y:32788,varname:node_1940,prsc:2,blmd:12,clmp:True|SRC-2692-OUT,DST-9693-OUT;n:type:ShaderForge.SFN_Slider,id:7807,x:32881,y:33058,ptovrint:False,ptlb:Opacity,ptin:_Opacity,varname:node_7807,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Slider,id:7636,x:34338,y:32517,ptovrint:False,ptlb:Metallic,ptin:_Metallic,varname:node_391,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Slider,id:8349,x:34338,y:32601,ptovrint:False,ptlb:Gloss,ptin:_Gloss,varname:node_9088,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Vector1,id:5911,x:32372,y:33821,varname:node_5911,prsc:2,v1:1;proporder:7241-9151-6611-1689-2514-5322-1516-7906-6331-1360-4622-4527-1083-3269-6792-1116-4067-8329-7636-8349-7807-4793-151-6904;pass:END;sub:END;*/

Shader "NoeNoe/NoeNoe Overlay Shader/PBR/NoeNoe PBR Transparent" {
    Properties {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Main texture (RGB)", 2D) = "white" {}
        _CrossfadeSurfaceOverlay ("Crossfade Surface / Overlay", Range(0, 2)) = 1
        _TileOverlay ("Tile Overlay", 2D) = "white" {}
        _TileSpeedX ("Tile Speed X", Range(-1, 1)) = 0
        _TileSpeedY ("Tile Speed Y", Range(-1, 1)) = 0
        _CubemapOverlay ("Cubemap Overlay", Cube) = "_Skybox" {}
        _CubemapRotationSpeed ("Cubemap Rotation Speed", Vector) = (0,0,0,0)
        _CrossfadeTileCubemap ("Crossfade Tile / Cubemap", Range(0, 2)) = 0
        [MaterialToggle] _DynamicToonLighting ("Dynamic Toon Lighting", Float ) = 0
        _StaticToonLight ("Static Toon Light", Vector) = (0,3,0,0)
        [MaterialToggle] _BillboardStaticLight ("Billboard Static Light", Float ) = 0
        _Ramp ("Ramp", 2D) = "white" {}
        _ToonContrast ("Toon Contrast", Range(0, 1)) = 0.25
        _EmissionMap ("Emission Map", 2D) = "white" {}
        _Emission ("Emission", Range(0, 10)) = 0
        _Intensity ("Intensity", Range(0, 10)) = 0.8
        _Saturation ("Saturation", Range(0, 1)) = 0.65
        _Metallic ("Metallic", Range(0, 1)) = 0
        _Gloss ("Gloss", Range(0, 1)) = 0
        _Opacity ("Opacity", Range(0, 1)) = 1
        _NormalMap ("Normal Map", 2D) = "bump" {}
        _StereoDistance ("Stereo Distance", Range(-5, 5)) = 0.5
        [MaterialToggle] _UseSurfaceDepth ("Use Surface Depth", Float ) = 0
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _TileOverlay; uniform float4 _TileOverlay_ST;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _CrossfadeSurfaceOverlay;
            uniform float _TileSpeedX;
            uniform float _TileSpeedY;
            uniform samplerCUBE _CubemapOverlay;
            uniform float _CrossfadeTileCubemap;
            uniform sampler2D _EmissionMap; uniform float4 _EmissionMap_ST;
            uniform float _Emission;
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform float _Intensity;
            uniform float4 _StaticToonLight;
            uniform sampler2D _Ramp; uniform float4 _Ramp_ST;
            float3 VRViewPosition(){
            #if defined(USING_STEREO_MATRICES)
            float3 leftEye = unity_StereoWorldSpaceCameraPos[0];
            float3 rightEye = unity_StereoWorldSpaceCameraPos[1];
            
            float3 centerEye = lerp(leftEye, rightEye, 0.5);
            #endif
            #if !defined(USING_STEREO_MATRICES)
            float3 centerEye = _WorldSpaceCameraPos;
            #endif
            return centerEye;
            }
            
            float3 VRViewDir( float3 player , float3 target ){
            float3 heading = target - player;
            float3 distance = length(heading);
            float3 direction = heading / distance;
            return -direction;
            }
            
            uniform float _StereoDistance;
            uniform float _Saturation;
            uniform fixed _BillboardStaticLight;
            uniform fixed _UseSurfaceDepth;
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
            uniform float _ToonContrast;
            uniform fixed _DynamicToonLighting;
            uniform float _Opacity;
            uniform float _Metallic;
            uniform float _Gloss;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float3 tangentDir : TEXCOORD5;
                float3 bitangentDir : TEXCOORD6;
                LIGHTING_COORDS(7,8)
                #if defined(LIGHTMAP_ON) || defined(UNITY_SHOULD_SAMPLE_SH)
                    float4 ambientOrLightmapUV : TEXCOORD9;
                #endif
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                #ifdef LIGHTMAP_ON
                    o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    o.ambientOrLightmapUV.zw = 0;
                #elif UNITY_SHOULD_SAMPLE_SH
                #endif
                #ifdef DYNAMICLIGHTMAP_ON
                    o.ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
                #endif
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _NormalMap_var = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(i.uv0, _NormalMap)));
                float3 normalLocal = _NormalMap_var.rgb;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float gloss = _Gloss;
                float perceptualRoughness = 1.0 - _Gloss;
                float roughness = perceptualRoughness * perceptualRoughness;
                float specPow = exp2( gloss * 10.0 + 1.0 );
/////// GI Data:
                UnityLight light;
                #ifdef LIGHTMAP_OFF
                    light.color = lightColor;
                    light.dir = lightDirection;
                    light.ndotl = LambertTerm (normalDirection, light.dir);
                #else
                    light.color = half3(0.f, 0.f, 0.f);
                    light.ndotl = 0.0f;
                    light.dir = half3(0.f, 0.f, 0.f);
                #endif
                UnityGIInput d;
                d.light = light;
                d.worldPos = i.posWorld.xyz;
                d.worldViewDir = viewDirection;
                d.atten = attenuation;
                #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
                    d.ambient = 0;
                    d.lightmapUV = i.ambientOrLightmapUV;
                #else
                    d.ambient = i.ambientOrLightmapUV;
                #endif
                #if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
                    d.boxMin[0] = unity_SpecCube0_BoxMin;
                    d.boxMin[1] = unity_SpecCube1_BoxMin;
                #endif
                #if UNITY_SPECCUBE_BOX_PROJECTION
                    d.boxMax[0] = unity_SpecCube0_BoxMax;
                    d.boxMax[1] = unity_SpecCube1_BoxMax;
                    d.probePosition[0] = unity_SpecCube0_ProbePosition;
                    d.probePosition[1] = unity_SpecCube1_ProbePosition;
                #endif
                d.probeHDR[0] = unity_SpecCube0_HDR;
                d.probeHDR[1] = unity_SpecCube1_HDR;
                Unity_GlossyEnvironmentData ugls_en_data;
                ugls_en_data.roughness = 1.0 - gloss;
                ugls_en_data.reflUVW = viewReflectDirection;
                UnityGI gi = UnityGlobalIllumination(d, 1, normalDirection, ugls_en_data );
                lightDirection = gi.light.dir;
                lightColor = gi.light.color;
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float LdotH = saturate(dot(lightDirection, halfDirection));
                float3 specularColor = _Metallic;
                float specularMonochrome;
                float FlatLighting = 1.0;
                float node_7920 = 1.0;
                float node_6078 = 1.0;
                float3 VRPosition = VRViewPosition();
                float node_4163_if_leA = step(_UseSurfaceDepth,1.0);
                float node_4163_if_leB = step(1.0,_UseSurfaceDepth);
                float node_2186 = 0.0;
                float node_2475 = clamp(distance(_WorldSpaceCameraPos,objPos.rgb),node_2186,1.5);
                float node_3721_if_leA = step(_UseSurfaceDepth,1.0);
                float node_3721_if_leB = step(1.0,_UseSurfaceDepth);
                float3 node_1541 = (normalize((i.posWorld.rgb-_WorldSpaceCameraPos))+_WorldSpaceCameraPos);
                float3 VRDirection = VRViewDir( lerp(VRPosition,_WorldSpaceCameraPos,(lerp((node_4163_if_leA*node_2475)+(node_4163_if_leB*node_2475),node_2186,node_4163_if_leA*node_4163_if_leB)+_StereoDistance)) , lerp((node_3721_if_leA*node_1541)+(node_3721_if_leB*node_1541),i.posWorld.rgb,node_3721_if_leA*node_3721_if_leB) );
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
                float OverlayFactor = saturate(_CrossfadeSurfaceOverlay);
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float SurfaceFactor = saturate((1.0+(1.0 - _CrossfadeSurfaceOverlay)));
                float3 MappedTexture = ((lerp(float3(node_7920,node_7920,node_7920),Overlay,OverlayFactor)*lerp(float3(node_7920,node_7920,node_7920),_MainTex_var.rgb,SurfaceFactor))*_Color.rgb);
                float3 Diffuse = lerp(lerp(MappedTexture,dot(MappedTexture,float3(0.3,0.59,0.11)),(-0.5)),dot(lerp(MappedTexture,dot(MappedTexture,float3(0.3,0.59,0.11)),(-0.5)),float3(0.3,0.59,0.11)),(1.0 - _Saturation));
                float node_424 = 0.5;
                float node_7394_if_leA = step(_BillboardStaticLight,1.0);
                float node_7394_if_leB = step(1.0,_BillboardStaticLight);
                float3 node_3406 = (i.posWorld.rgb-VRPosition);
                float3 node_1153 = (-1*(node_3406/length(node_3406))).rgb;
                float2 node_7017 = normalize(float2(node_1153.r,node_1153.b));
                float2 node_7930 = node_7017.rg;
                float2 node_8628 = (float2((-1*node_7930.g),node_7930.r)*(-1*_StaticToonLight.r)).rg;
                float2 node_3851 = (node_7017*_StaticToonLight.b).rg;
                float3 StaticLightDirection = lerp((node_7394_if_leA*_StaticToonLight.rgb)+(node_7394_if_leB*_StaticToonLight.rgb),(float3(node_8628.r,_StaticToonLight.g,node_8628.g)+float3(node_3851.r,_StaticToonLight.g,node_3851.g)),node_7394_if_leA*node_7394_if_leB);
                float node_1617 = 0.5*dot(normalDirection,StaticLightDirection)+0.5;
                float2 node_8091 = float2(node_1617,node_1617);
                float4 node_9498 = tex2D(_Ramp,TRANSFORM_TEX(node_8091, _Ramp));
                float3 StaticToonLighting = node_9498.rgb;
                float node_3734 = 1.0;
                float node_5356_if_leA = step(_DynamicToonLighting,node_3734);
                float node_5356_if_leB = step(node_3734,_DynamicToonLighting);
                float node_8152 = 0.5*dot(normalDirection,lightDirection)+0.5;
                float2 node_795 = float2(node_8152,node_8152);
                float4 node_3501 = tex2D(_Ramp,TRANSFORM_TEX(node_795, _Ramp));
                float3 DynamicToonLighting = lerp((node_5356_if_leA*node_3734)+(node_5356_if_leB*node_3734),node_3501.rgb,node_5356_if_leA*node_5356_if_leB);
                float3 diffuseColor = saturate(((_Intensity*FlatLighting*Diffuse) > 0.5 ?  (1.0-(1.0-2.0*((_Intensity*FlatLighting*Diffuse)-0.5))*(1.0-lerp(float3(node_424,node_424,node_424),(StaticToonLighting*DynamicToonLighting),_ToonContrast))) : (2.0*(_Intensity*FlatLighting*Diffuse)*lerp(float3(node_424,node_424,node_424),(StaticToonLighting*DynamicToonLighting),_ToonContrast))) ); // Need this for specular when using metallic
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, specularColor, specularColor, specularMonochrome );
                specularMonochrome = 1.0-specularMonochrome;
                float NdotV = abs(dot( normalDirection, viewDirection ));
                float NdotH = saturate(dot( normalDirection, halfDirection ));
                float VdotH = saturate(dot( viewDirection, halfDirection ));
                float visTerm = SmithJointGGXVisibilityTerm( NdotL, NdotV, roughness );
                float normTerm = GGXTerm(NdotH, roughness);
                float specularPBL = (visTerm*normTerm) * UNITY_PI;
                #ifdef UNITY_COLORSPACE_GAMMA
                    specularPBL = sqrt(max(1e-4h, specularPBL));
                #endif
                specularPBL = max(0, specularPBL * NdotL);
                #if defined(_SPECULARHIGHLIGHTS_OFF)
                    specularPBL = 0.0;
                #endif
                half surfaceReduction;
                #ifdef UNITY_COLORSPACE_GAMMA
                    surfaceReduction = 1.0-0.28*roughness*perceptualRoughness;
                #else
                    surfaceReduction = 1.0/(roughness*roughness + 1.0);
                #endif
                specularPBL *= any(specularColor) ? 1.0 : 0.0;
                float3 directSpecular = attenColor*specularPBL*FresnelTerm(specularColor, LdotH);
                half grazingTerm = saturate( gloss + specularMonochrome );
                float3 indirectSpecular = (gi.indirect.specular);
                indirectSpecular *= FresnelLerp (specularColor, grazingTerm, NdotV);
                indirectSpecular *= surfaceReduction;
                float3 specular = (directSpecular + indirectSpecular);
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float nlPow5 = Pow5(1-NdotL);
                float nvPow5 = Pow5(1-NdotV);
                float3 directDiffuse = ((1 +(fd90 - 1)*nlPow5) * (1 + (fd90 - 1)*nvPow5) * NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += gi.indirect.diffuse;
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
////// Emissive:
                float4 _EmissionMap_var = tex2D(_EmissionMap,TRANSFORM_TEX(i.uv0, _EmissionMap));
                float3 MappedEmissive = (_EmissionMap_var.rgb*_Emission);
                float3 emissive = MappedEmissive;
/// Final Color:
                float3 finalColor = diffuse + specular + emissive;
                float SurfaceAlpha = _MainTex_var.a;
                float OverlayAlpha = _TileOverlay_var.a;
                return fixed4(finalColor,(SurfaceAlpha*OverlayAlpha*_Opacity));
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _TileOverlay; uniform float4 _TileOverlay_ST;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _CrossfadeSurfaceOverlay;
            uniform float _TileSpeedX;
            uniform float _TileSpeedY;
            uniform samplerCUBE _CubemapOverlay;
            uniform float _CrossfadeTileCubemap;
            uniform sampler2D _EmissionMap; uniform float4 _EmissionMap_ST;
            uniform float _Emission;
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform float _Intensity;
            uniform float4 _StaticToonLight;
            uniform sampler2D _Ramp; uniform float4 _Ramp_ST;
            float3 VRViewPosition(){
            #if defined(USING_STEREO_MATRICES)
            float3 leftEye = unity_StereoWorldSpaceCameraPos[0];
            float3 rightEye = unity_StereoWorldSpaceCameraPos[1];
            
            float3 centerEye = lerp(leftEye, rightEye, 0.5);
            #endif
            #if !defined(USING_STEREO_MATRICES)
            float3 centerEye = _WorldSpaceCameraPos;
            #endif
            return centerEye;
            }
            
            float3 VRViewDir( float3 player , float3 target ){
            float3 heading = target - player;
            float3 distance = length(heading);
            float3 direction = heading / distance;
            return -direction;
            }
            
            uniform float _StereoDistance;
            uniform float _Saturation;
            uniform fixed _BillboardStaticLight;
            uniform fixed _UseSurfaceDepth;
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
            uniform float _ToonContrast;
            uniform fixed _DynamicToonLighting;
            uniform float _Opacity;
            uniform float _Metallic;
            uniform float _Gloss;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float3 tangentDir : TEXCOORD5;
                float3 bitangentDir : TEXCOORD6;
                LIGHTING_COORDS(7,8)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _NormalMap_var = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(i.uv0, _NormalMap)));
                float3 normalLocal = _NormalMap_var.rgb;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float gloss = _Gloss;
                float perceptualRoughness = 1.0 - _Gloss;
                float roughness = perceptualRoughness * perceptualRoughness;
                float specPow = exp2( gloss * 10.0 + 1.0 );
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float LdotH = saturate(dot(lightDirection, halfDirection));
                float3 specularColor = _Metallic;
                float specularMonochrome;
                float FlatLighting = 1.0;
                float node_7920 = 1.0;
                float node_6078 = 1.0;
                float3 VRPosition = VRViewPosition();
                float node_4163_if_leA = step(_UseSurfaceDepth,1.0);
                float node_4163_if_leB = step(1.0,_UseSurfaceDepth);
                float node_2186 = 0.0;
                float node_2475 = clamp(distance(_WorldSpaceCameraPos,objPos.rgb),node_2186,1.5);
                float node_3721_if_leA = step(_UseSurfaceDepth,1.0);
                float node_3721_if_leB = step(1.0,_UseSurfaceDepth);
                float3 node_1541 = (normalize((i.posWorld.rgb-_WorldSpaceCameraPos))+_WorldSpaceCameraPos);
                float3 VRDirection = VRViewDir( lerp(VRPosition,_WorldSpaceCameraPos,(lerp((node_4163_if_leA*node_2475)+(node_4163_if_leB*node_2475),node_2186,node_4163_if_leA*node_4163_if_leB)+_StereoDistance)) , lerp((node_3721_if_leA*node_1541)+(node_3721_if_leB*node_1541),i.posWorld.rgb,node_3721_if_leA*node_3721_if_leB) );
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
                float OverlayFactor = saturate(_CrossfadeSurfaceOverlay);
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float SurfaceFactor = saturate((1.0+(1.0 - _CrossfadeSurfaceOverlay)));
                float3 MappedTexture = ((lerp(float3(node_7920,node_7920,node_7920),Overlay,OverlayFactor)*lerp(float3(node_7920,node_7920,node_7920),_MainTex_var.rgb,SurfaceFactor))*_Color.rgb);
                float3 Diffuse = lerp(lerp(MappedTexture,dot(MappedTexture,float3(0.3,0.59,0.11)),(-0.5)),dot(lerp(MappedTexture,dot(MappedTexture,float3(0.3,0.59,0.11)),(-0.5)),float3(0.3,0.59,0.11)),(1.0 - _Saturation));
                float node_424 = 0.5;
                float node_7394_if_leA = step(_BillboardStaticLight,1.0);
                float node_7394_if_leB = step(1.0,_BillboardStaticLight);
                float3 node_3406 = (i.posWorld.rgb-VRPosition);
                float3 node_1153 = (-1*(node_3406/length(node_3406))).rgb;
                float2 node_7017 = normalize(float2(node_1153.r,node_1153.b));
                float2 node_7930 = node_7017.rg;
                float2 node_8628 = (float2((-1*node_7930.g),node_7930.r)*(-1*_StaticToonLight.r)).rg;
                float2 node_3851 = (node_7017*_StaticToonLight.b).rg;
                float3 StaticLightDirection = lerp((node_7394_if_leA*_StaticToonLight.rgb)+(node_7394_if_leB*_StaticToonLight.rgb),(float3(node_8628.r,_StaticToonLight.g,node_8628.g)+float3(node_3851.r,_StaticToonLight.g,node_3851.g)),node_7394_if_leA*node_7394_if_leB);
                float node_1617 = 0.5*dot(normalDirection,StaticLightDirection)+0.5;
                float2 node_8091 = float2(node_1617,node_1617);
                float4 node_9498 = tex2D(_Ramp,TRANSFORM_TEX(node_8091, _Ramp));
                float3 StaticToonLighting = node_9498.rgb;
                float node_3734 = 1.0;
                float node_5356_if_leA = step(_DynamicToonLighting,node_3734);
                float node_5356_if_leB = step(node_3734,_DynamicToonLighting);
                float node_8152 = 0.5*dot(normalDirection,lightDirection)+0.5;
                float2 node_795 = float2(node_8152,node_8152);
                float4 node_3501 = tex2D(_Ramp,TRANSFORM_TEX(node_795, _Ramp));
                float3 DynamicToonLighting = lerp((node_5356_if_leA*node_3734)+(node_5356_if_leB*node_3734),node_3501.rgb,node_5356_if_leA*node_5356_if_leB);
                float3 diffuseColor = saturate(((_Intensity*FlatLighting*Diffuse) > 0.5 ?  (1.0-(1.0-2.0*((_Intensity*FlatLighting*Diffuse)-0.5))*(1.0-lerp(float3(node_424,node_424,node_424),(StaticToonLighting*DynamicToonLighting),_ToonContrast))) : (2.0*(_Intensity*FlatLighting*Diffuse)*lerp(float3(node_424,node_424,node_424),(StaticToonLighting*DynamicToonLighting),_ToonContrast))) ); // Need this for specular when using metallic
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, specularColor, specularColor, specularMonochrome );
                specularMonochrome = 1.0-specularMonochrome;
                float NdotV = abs(dot( normalDirection, viewDirection ));
                float NdotH = saturate(dot( normalDirection, halfDirection ));
                float VdotH = saturate(dot( viewDirection, halfDirection ));
                float visTerm = SmithJointGGXVisibilityTerm( NdotL, NdotV, roughness );
                float normTerm = GGXTerm(NdotH, roughness);
                float specularPBL = (visTerm*normTerm) * UNITY_PI;
                #ifdef UNITY_COLORSPACE_GAMMA
                    specularPBL = sqrt(max(1e-4h, specularPBL));
                #endif
                specularPBL = max(0, specularPBL * NdotL);
                #if defined(_SPECULARHIGHLIGHTS_OFF)
                    specularPBL = 0.0;
                #endif
                specularPBL *= any(specularColor) ? 1.0 : 0.0;
                float3 directSpecular = attenColor*specularPBL*FresnelTerm(specularColor, LdotH);
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float nlPow5 = Pow5(1-NdotL);
                float nvPow5 = Pow5(1-NdotV);
                float3 directDiffuse = ((1 +(fd90 - 1)*nlPow5) * (1 + (fd90 - 1)*nvPow5) * NdotL) * attenColor;
                float3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                float SurfaceAlpha = _MainTex_var.a;
                float OverlayAlpha = _TileOverlay_var.a;
                return fixed4(finalColor * (SurfaceAlpha*OverlayAlpha*_Opacity),0);
            }
            ENDCG
        }
        Pass {
            Name "Meta"
            Tags {
                "LightMode"="Meta"
            }
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_META 1
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "UnityMetaPass.cginc"
            #include "AutoLight.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _TileOverlay; uniform float4 _TileOverlay_ST;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _CrossfadeSurfaceOverlay;
            uniform float _TileSpeedX;
            uniform float _TileSpeedY;
            uniform samplerCUBE _CubemapOverlay;
            uniform float _CrossfadeTileCubemap;
            uniform sampler2D _EmissionMap; uniform float4 _EmissionMap_ST;
            uniform float _Emission;
            uniform float _Intensity;
            uniform float4 _StaticToonLight;
            uniform sampler2D _Ramp; uniform float4 _Ramp_ST;
            float3 VRViewPosition(){
            #if defined(USING_STEREO_MATRICES)
            float3 leftEye = unity_StereoWorldSpaceCameraPos[0];
            float3 rightEye = unity_StereoWorldSpaceCameraPos[1];
            
            float3 centerEye = lerp(leftEye, rightEye, 0.5);
            #endif
            #if !defined(USING_STEREO_MATRICES)
            float3 centerEye = _WorldSpaceCameraPos;
            #endif
            return centerEye;
            }
            
            float3 VRViewDir( float3 player , float3 target ){
            float3 heading = target - player;
            float3 distance = length(heading);
            float3 direction = heading / distance;
            return -direction;
            }
            
            uniform float _StereoDistance;
            uniform float _Saturation;
            uniform fixed _BillboardStaticLight;
            uniform fixed _UseSurfaceDepth;
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
            uniform float _ToonContrast;
            uniform fixed _DynamicToonLighting;
            uniform float _Metallic;
            uniform float _Gloss;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST );
                return o;
            }
            float4 frag(VertexOutput i) : SV_Target {
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                UnityMetaInput o;
                UNITY_INITIALIZE_OUTPUT( UnityMetaInput, o );
                
                float4 _EmissionMap_var = tex2D(_EmissionMap,TRANSFORM_TEX(i.uv0, _EmissionMap));
                float3 MappedEmissive = (_EmissionMap_var.rgb*_Emission);
                o.Emission = MappedEmissive;
                
                float FlatLighting = 1.0;
                float node_7920 = 1.0;
                float node_6078 = 1.0;
                float3 VRPosition = VRViewPosition();
                float node_4163_if_leA = step(_UseSurfaceDepth,1.0);
                float node_4163_if_leB = step(1.0,_UseSurfaceDepth);
                float node_2186 = 0.0;
                float node_2475 = clamp(distance(_WorldSpaceCameraPos,objPos.rgb),node_2186,1.5);
                float node_3721_if_leA = step(_UseSurfaceDepth,1.0);
                float node_3721_if_leB = step(1.0,_UseSurfaceDepth);
                float3 node_1541 = (normalize((i.posWorld.rgb-_WorldSpaceCameraPos))+_WorldSpaceCameraPos);
                float3 VRDirection = VRViewDir( lerp(VRPosition,_WorldSpaceCameraPos,(lerp((node_4163_if_leA*node_2475)+(node_4163_if_leB*node_2475),node_2186,node_4163_if_leA*node_4163_if_leB)+_StereoDistance)) , lerp((node_3721_if_leA*node_1541)+(node_3721_if_leB*node_1541),i.posWorld.rgb,node_3721_if_leA*node_3721_if_leB) );
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
                float OverlayFactor = saturate(_CrossfadeSurfaceOverlay);
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float SurfaceFactor = saturate((1.0+(1.0 - _CrossfadeSurfaceOverlay)));
                float3 MappedTexture = ((lerp(float3(node_7920,node_7920,node_7920),Overlay,OverlayFactor)*lerp(float3(node_7920,node_7920,node_7920),_MainTex_var.rgb,SurfaceFactor))*_Color.rgb);
                float3 Diffuse = lerp(lerp(MappedTexture,dot(MappedTexture,float3(0.3,0.59,0.11)),(-0.5)),dot(lerp(MappedTexture,dot(MappedTexture,float3(0.3,0.59,0.11)),(-0.5)),float3(0.3,0.59,0.11)),(1.0 - _Saturation));
                float node_424 = 0.5;
                float node_7394_if_leA = step(_BillboardStaticLight,1.0);
                float node_7394_if_leB = step(1.0,_BillboardStaticLight);
                float3 node_3406 = (i.posWorld.rgb-VRPosition);
                float3 node_1153 = (-1*(node_3406/length(node_3406))).rgb;
                float2 node_7017 = normalize(float2(node_1153.r,node_1153.b));
                float2 node_7930 = node_7017.rg;
                float2 node_8628 = (float2((-1*node_7930.g),node_7930.r)*(-1*_StaticToonLight.r)).rg;
                float2 node_3851 = (node_7017*_StaticToonLight.b).rg;
                float3 StaticLightDirection = lerp((node_7394_if_leA*_StaticToonLight.rgb)+(node_7394_if_leB*_StaticToonLight.rgb),(float3(node_8628.r,_StaticToonLight.g,node_8628.g)+float3(node_3851.r,_StaticToonLight.g,node_3851.g)),node_7394_if_leA*node_7394_if_leB);
                float node_1617 = 0.5*dot(normalDirection,StaticLightDirection)+0.5;
                float2 node_8091 = float2(node_1617,node_1617);
                float4 node_9498 = tex2D(_Ramp,TRANSFORM_TEX(node_8091, _Ramp));
                float3 StaticToonLighting = node_9498.rgb;
                float node_3734 = 1.0;
                float node_5356_if_leA = step(_DynamicToonLighting,node_3734);
                float node_5356_if_leB = step(node_3734,_DynamicToonLighting);
                float node_8152 = 0.5*dot(normalDirection,lightDirection)+0.5;
                float2 node_795 = float2(node_8152,node_8152);
                float4 node_3501 = tex2D(_Ramp,TRANSFORM_TEX(node_795, _Ramp));
                float3 DynamicToonLighting = lerp((node_5356_if_leA*node_3734)+(node_5356_if_leB*node_3734),node_3501.rgb,node_5356_if_leA*node_5356_if_leB);
                float3 diffColor = saturate(((_Intensity*FlatLighting*Diffuse) > 0.5 ?  (1.0-(1.0-2.0*((_Intensity*FlatLighting*Diffuse)-0.5))*(1.0-lerp(float3(node_424,node_424,node_424),(StaticToonLighting*DynamicToonLighting),_ToonContrast))) : (2.0*(_Intensity*FlatLighting*Diffuse)*lerp(float3(node_424,node_424,node_424),(StaticToonLighting*DynamicToonLighting),_ToonContrast))) );
                float specularMonochrome;
                float3 specColor;
                diffColor = DiffuseAndSpecularFromMetallic( diffColor, _Metallic, specColor, specularMonochrome );
                float roughness = 1.0 - _Gloss;
                o.Albedo = diffColor + specColor * roughness * roughness * 0.5;
                
                return UnityMetaFragment( o );
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
