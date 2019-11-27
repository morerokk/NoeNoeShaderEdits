float _TargetEye;
float _MaxLookRange;
float _EyeTrackingScrollSpeed;
float _EyeTrackingBlur;
float _EyeTrackingRotationCorrection;
sampler2D _EyeTrackingPatternTex;

inline float3x3 xRotation3dRadians(float rad) {
    float s = sin(rad);
    float c = cos(rad);
    return float3x3(
        1, 0, 0,
        0, c, s,
        0, -s, c);
}

inline float3x3 yRotation3dRadians(float rad) {
    float s = sin(rad);
    float c = cos(rad);
    return float3x3(
        c, 0, -s,
        0, 1, 0,
        s, 0, c);
}
 
inline float3x3 zRotation3dRadians(float rad) {
    float s = sin(rad);
    float c = cos(rad);
    return float3x3(
        c, s, 0,
        -s, c, 0,
        0, 0, 1);
}

float3 GetEyePos()
{
    #if defined(USING_STEREO_MATRICES)
        return lerp(unity_StereoWorldSpaceCameraPos[0], unity_StereoWorldSpaceCameraPos[1], (_TargetEye * 0.5));
    #else
        return _WorldSpaceCameraPos;
    #endif
}

float rand(float3 myVector)
{
    return frac(sin( dot(myVector ,float3(12.9898,78.233,45.5432) )) * 43758.5453);
}

float EyeTrackingCurve(float t)
{
    // Scroll the current pixel value based on time
    float4 currentCol = tex2Dlod(_EyeTrackingPatternTex, float4(t * 0.01 * _EyeTrackingScrollSpeed, 0.5, 0, _EyeTrackingBlur));
    return currentCol.r;
}

VertexOutput vertEyeTracking (VertexInput v) {  

    //World pos of mesh origin
    float3 worldPos = mul(unity_ObjectToWorld, float4(0, 0, 0, 1)).xyz;
    
    //Fix rotation
    v.vertex.xyz = mul(yRotation3dRadians(radians(180)), v.vertex.xyz);
    
    //Fix blender rotation
    if(_EyeTrackingRotationCorrection == 1)
    {
        v.vertex.xyz = mul(xRotation3dRadians(radians(-90)), v.vertex.xyz);
    }
    
    //Get scale
    float4 modelX = float4(1.0, 0.0, 0.0, 0.0);
    float4 modelY = float4(0.0, 1.0, 0.0, 0.0);
    float4 modelZ = float4(0.0, 0.0, 1.0, 0.0);
     
    float4 modelXInWorld = mul(unity_ObjectToWorld, modelX);
    float4 modelYInWorld = mul(unity_ObjectToWorld, modelY);
    float4 modelZInWorld = mul(unity_ObjectToWorld, modelZ);
     
    float scaleX = length(modelXInWorld);
    float scaleY = length(modelYInWorld);
    float scaleZ = length(modelZInWorld);
    
    // Pre-apply scale
    v.vertex.xyz *= float3(scaleX, scaleY, scaleZ);
    
    // Distance between the camera and the mesh origin
    float3 worldCamPos = GetEyePos();
    float3 dist = worldCamPos - worldPos;
    
    float3 camVect = normalize(worldPos - worldCamPos);
    
    //Check if the camera is behind the eye
    float3 behindDir = float3(0,0,1);
    if(dot(camVect, behindDir) > _MaxLookRange)
    {
        camVect = float3(0,0,-1);
    }
    
    //Look forward or to the camera depending on texture
    float3 forwardVect = float3(0,0,-1);
    float lerpValue = EyeTrackingCurve(_Time.y);
    camVect = normalize(lerp(forwardVect, camVect, saturate(lerpValue)));
    
    float angle = atan2(dist.x, dist.z);
    
    float3x3 rotMatrix;
    float cosinus = cos(angle);
    float sinus = sin(angle);
    float tang = (dist.x / dist.z);

    // "Up" should actually match the object rotation so the eyes don't roll around in their sockets
    float3 up = mul(unity_ObjectToWorld, float4(0,1,0,1)).xyz;

    float3 zaxis = camVect;
    float3 xaxis = normalize(cross(up, camVect));
    float3 yaxis = cross(camVect, xaxis);

    float3x3 lookatMatrix = {
        xaxis.x,            yaxis.x,            zaxis.x,
        xaxis.y,            yaxis.y,            zaxis.y,
        xaxis.z,            yaxis.z,            zaxis.z
    };

    // Rotation matrix in Y
    rotMatrix[0].xyz = float3(cosinus, 0, sinus);
    rotMatrix[1].xyz = float3(0, 1, 0);
    rotMatrix[2].xyz = float3(- sinus, 0, cosinus);

    // The position of the vertex after the rotation
    //float4 newPos = float4(mul(lookatMatrix, v.vertex * float4(1,1,1,0)), 1);
    float4 newPos = float4(mul(lookatMatrix, v.vertex), 1);
    
    // The model matrix without the rotation and scale
    float4x4 matrix_M_noRot = unity_ObjectToWorld;
    matrix_M_noRot[0][0] = 1;
    matrix_M_noRot[0][1] = 0;
    matrix_M_noRot[0][2] = 0;

    matrix_M_noRot[1][0] = 0;
    matrix_M_noRot[1][1] = 1;
    matrix_M_noRot[1][2] = 0;

    matrix_M_noRot[2][0] = 0;
    matrix_M_noRot[2][1] = 0;
    matrix_M_noRot[2][2] = 1;

    VertexOutput o = (VertexOutput)0;
    
    o.uv0 = v.texcoord0;
    o.normalDir = UnityObjectToWorldNormal(v.normal);
    o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
    o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
    o.posWorld = mul(unity_ObjectToWorld, v.vertex);
    float3 lightColor = _LightColor0.rgb;
    
    o.pos = mul(UNITY_MATRIX_VP, mul(matrix_M_noRot, newPos));

    TRANSFER_VERTEX_TO_FRAGMENT(o)
    return o;
}