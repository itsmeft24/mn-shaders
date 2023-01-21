
#define USES_WORLDSHADOWMAP
#define USES_TEXCOORD0

#include "360_Globals.h"

VS_OUTPUT vs_main( VS_INPUT IN )
{
   return GenerateVertexShaderOutput( IN );
}

float4 ps_main( VS_OUTPUT IN ) : COLOR
{
   float4 texDiffuse0 = tex2D( TexMap0, IN.TexCoord0 );
   
   LIGHT_OUTPUT L;
   
   L.NonAmbientColor = texDiffuse0 * 0.30 + 0.70;
   L.AmbientColor    = 0;
   
   return CalculateFinalColor( IN, L, 1 );
}
