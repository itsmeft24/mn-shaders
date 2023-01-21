
#define USES_DYNAMICSHADOWMAP
#define USES_TEXCOORD0

#include "360_Globals.h"

VS_OUTPUT vs_main( VS_INPUT IN )
{
   return GenerateVertexShaderOutput( IN );
}

float4 ps_main( VS_OUTPUT IN ) : COLOR
{
   float3 texDiffuse0 = tex2D( TexMap0, IN.TexCoord0 );

   if ( IN.TexShadow.x < 0.0 || IN.TexShadow.x >= 1.0 || IN.TexShadow.y < 0.0 || IN.TexShadow.y >= 1.0 )
   {
      float3 range = { 0.10, 0.30, 0.30 };
      
      return float4( ( texDiffuse0 * range + ( 1 - range ) ) * 0.25, 1 );
   }
   else
   {
      float3 shadowColor = CalculateShadowColor( IN, 1.0 );
      
      shadowColor = ( shadowColor - PS_ShadowColor ) * ( PS_ShadowColor / ( 1.0 - PS_ShadowColor ) );
   
      float3 range = { 0.30, 0.30, 0.30 };
      
      return float4( ( texDiffuse0 * range + ( 1 - range ) ) * 0.25 * shadowColor, 1 );
   }
}
