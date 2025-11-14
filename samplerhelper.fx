#ifndef HLSL_SAPLERHELPER
#define HLSL_SAPLERHELPER

#if APIABSTRACTION_D3D11

#define sample2D(sampler, texCoord, textureDX11) \
	textureDX11.Sample(sampler, texCoord)

#elif APIABSTRACTION_D3D9

// note for DX 9 texture is ignored, because a texture is bound to sampler itself
#define sample2D(sampler, texCoord, textureDX11) \
	tex2D(sampler, texCoord)
	
#elif APIABSTRACTION_IOS

    #define sample2D(sampler, texCoord, textureDX11) \
        texture2D(sampler, texCoord)

#else // OGL CG

#define sample2D(sampler, texCoord, textureDX11) \
	tex2D(sampler, texCoord)

#endif

#if APIABSTRACTION_D3D11

#define sample(sampler, texCoord, textureDX11) \
	textureDX11.Sample(sampler, texCoord)

#elif APIABSTRACTION_D3D9

// note for DX 9 texture is ignored
#define sample(sampler, texCoord, textureDX11) \
	tex2D(sampler, texCoord)
#endif


#if APIABSTRACTION_D3D11

#define sampleCUBE(sampler, texCoord, textureDX11) \
	textureDX11.Sample(sampler, texCoord)

#elif APIABSTRACTION_D3D9

// note for DX 9 texture is ignored
#define sampleCUBE(sampler, texCoord, textureDX11) \
	texCUBE(sampler, texCoord)
#endif


#if APIABSTRACTION_D3D11

#define sampleTEXARRAY(sampler, texCoord, textureDX11) \
	textureDX11.Sample(sampler, texCoord)

#elif APIABSTRACTION_D3D9

// ot implemented
#define sampleTEXARRAY(sampler, texCoord, textureDX11) \
	tex2D(sampler, texCoord)
#endif


#if APIABSTRACTION_D3D11

#define sampleLevel(sampler, texCoord, level, textureDX11) \
	textureDX11.SampleLevel(sampler, texCoord, level)

#elif APIABSTRACTION_D3D9

// not implemented
#define sampleLevel(sampler, texCoord, textureDX11) \
	tex2D(sampler, texCoord)
#endif

float2 CubeAs2D(float3 direction, float2 texCoord)
{
    float absX = abs(direction.x);
    float absY = abs(direction.y);
    float absZ = abs(direction.z);

    float maxAxis, u, v;
    float2 faceOffset;

    if (absX >= absY && absX >= absZ)
    {
        
        if (direction.x > 0)
        {
            //+X
            maxAxis = absX;
            u = direction.z;
            v = -direction.y;
            faceOffset.x = 0.0; 
        }
        else
        {
            //-X
            maxAxis = absX;
            u = -direction.z;
            v = -direction.y;
            faceOffset.x = 1.0 / 6.0; 
        }
    }
    else if (absY >= absX && absY >= absZ)
    {
        
        if (direction.y > 0)
        {
            // +Y
            maxAxis = absY;
            u = direction.x;
            v = -direction.z;
            faceOffset.x = 2.0 / 6.0; // Offset for +Y face
        }
        else
        {
            // -Y
            maxAxis = absY;
            u = direction.x;
            v = direction.z;
            faceOffset.x = 3.0 / 6.0; // Offset for -Y face
        }
    }
    else
    {
        if (direction.z > 0)
        {
            // +Z
            maxAxis = absZ;
            u = -direction.x;
            v = -direction.y;
            faceOffset.x = 4.0 / 6.0; // Offset for +Z face
        }
        else
        {
            // -Z
            maxAxis = absZ;
            u = direction.x;
            v = -direction.y;
            faceOffset.x = 5.0 / 6.0; // Offset for -Z face
        }
    }

   
    u = 0.5 * (u / maxAxis + 1.0);
    v = 0.5 * (v / maxAxis + 1.0);

    
    float2 finalTexCoord = float2(u / 6.0 + faceOffset.x, v);
    return finalTexCoord;

}


#endif
