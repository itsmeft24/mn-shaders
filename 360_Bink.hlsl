
sampler tex0   : register( s0 );
sampler tex1   : register( s1 );
sampler tex2   : register( s2 );
float4  tor    : register( c0 );
float4  tog    : register( c1 );
float4  tob    : register( c2 );
float4  consts : register( c3 );

void vs_main( float4 Pos : POSITION, float4 Tex  : TEXCOORD0,
	 out float4 oPos : POSITION, 
	out float4 oTex0  : TEXCOORD0, 
	out float4 oTex1  : TEXCOORD1, 
	out float4 oTex2  : TEXCOORD2,
	out float4 oTex3  : TEXCOORD3)
{
	oPos = float4(0,0,0,0);
	oTex0 = Tex;
	oTex1 = Tex;
	oTex2 = Tex;
	oTex3 = Tex;
}

float4 ps_main( float4 Tex0  : TEXCOORD0, float4 Tex1  : TEXCOORD1, float4 Tex2  : TEXCOORD2 ) : COLOR
{
   float4 c;

   c.x = tex2D( tex0, Tex0 ).x;
   c.y = tex2D( tex1, Tex1 ).x;
   c.z = tex2D( tex2, Tex2 ).x;
   c.w = consts.x;

   float4 p;

   p.x = dot( tor, c );
   p.y = dot( tog, c );
   p.z = dot( tob, c );
   p.w = consts.w;
   
   return p;
}
