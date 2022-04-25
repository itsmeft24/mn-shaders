
#define POSITION_ALREADY_IN_WORLD_SPACE

#define USES_ECOLIGHTS
#define USES_ECOSYSTEM
#define USES_TEXCOORD0
#define USES_WORLDSHADOWMAP
//#define USES_FOG

#include "360_Globals.h"

VS_OUTPUT vs_main( VS_INPUT IN )
{
	float4 worldPosition = ( IN.Position * VS_ShrubberyScale + VS_ShrubberyOffset ) + ( IN.Delta * VS_VegetationVector );
	
	//FOG_OUTPUT fog = CalculateFog( worldPosition );
	float Distance = length(worldPosition - VS_WorldCameraPosition);

	VS_OUTPUT OUT;
	
	OUT.Position	   = mul( worldPosition, VS_WorldViewProjMatrix );
	OUT.Color		   = float4( VS_VegetationColors[ IN.Data.y ].rgb, 1 - ( Distance - VS_ShrubberyRange.x ) * VS_ShrubberyRange.y );
	OUT.TexCoord0	   = IN.TexCoord0;
   OUT.TexCoord2     = ( worldPosition.xz - VS_WorldShadowMapRegion.xy ) * VS_WorldShadowMapRegion.zw;
   OUT.TexCoord2.y   = 1 - OUT.TexCoord2.y;
	//OUT.Fog			   = fog.Fog;
	
	return OUT;
}

float4 ps_main( PS_INPUT IN ) : COLOR
{
   float4 texDiffuse0 = tex2D( TexMap0, IN.TexCoord0 );
   
   LIGHT_OUTPUT L;
   
   L.NonAmbientColor = texDiffuse0 * IN.Color;
   L.AmbientColor    = texDiffuse0 * PS_AmbientColor;
   
   return CalculateFinalColor( IN, L, texDiffuse0.a * IN.Color.a );
}
