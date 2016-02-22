Shader "Anclin/Experiments/Vertex Animation"
{
	Properties
	{
		_Value1( "Value 1", Float ) = 0
		_Value2( "Value 2", Float ) = 0
		_Value3( "Value 3", Float ) = 0
	}
	
	SubShader
	{
		Pass
		{
			Tags { "LightMode" = "ForwardBase" }

			// Render faces when looking from the inside
			Cull Off

			CGPROGRAM

			// Pragmas
			#pragma vertex vert
			#pragma fragment frag

			// User defined variables
			uniform float4 _Color;
			uniform float _Value1;
			uniform float _Value2;
			uniform float _Value3;

			// Base input structs
			struct vertexInput
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 texcoord : TEXCOORD0;
			};

			struct fragmentInput
			{
				float4 pos : SV_POSITION;
				float4 color : COLOR;
			};

			// Vertex function
			fragmentInput vert( vertexInput i )
			{
				fragmentInput o;

				// VERTEX ANIMATION ///////////////////////////////////////////////////////////////

				// Fat mesh
				// i.vertex.xyz += i.normal * _Value1;
				
				// Waving mesh
				i.vertex.x += sin( ( i.vertex.y + _Time * _Value3 ) * _Value2 ) * _Value1;

				// Bubbling mesh
				// i.vertex.xyz += i.normal * ( sin( (i.vertex.x + _Time * _Value3) * _Value2 ) + cos( (i.vertex.z + _Time * _Value3) * _Value2 )  ) * _Value1;

				//////////////////////////////////////////////////////////// EO VERTEX ANIMATION //

				// COLOR
				// o.color = i.texcoord;								// UV
				o.color = float4( i.normal, 1 ) * 0.5 + 0.5;		// Normals

				// This line must be after the vertex manipulation
				o.pos = mul( UNITY_MATRIX_MVP, i.vertex );
				return o;
			}

			// Fragment function
			float4 frag( fragmentInput i ) : Color
			{
				return i.color;
			}

			ENDCG
		}
	}

	// Fallback commented out during development
	// Fallback "Diffuse"
}
