Shader "Custom/08_VertexColorMask"
{
    Properties
    {
       
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Tex1("Tex1",2D)="white" {}
        _Tex2("Tex1",2D)="white" {}
        _Tex3("Tex1",2D)="white" {}

        
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _Tex1;
        sampler2D _Tex2;
        sampler2D _Tex3;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_Tex1;
            float2 uv_Tex2;
            float2 uv_Tex3;

            float4 color: COLOR;
        };


        
        UNITY_INSTANCING_BUFFER_START(Props)
          
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
           
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 c2 = tex2D (_Tex1, IN.uv_Tex1);
            fixed4 c3 = tex2D (_Tex2, IN.uv_Tex2);
            fixed4 c4 = tex2D (_Tex3, IN.uv_Tex3);

            //fixed3 res= lerp(c.rgb,c2.rgb,IN.color.r);
            //res=lerp(res.rgb,c3.rgb,IN.color.g);
            //res=lerp(res.rgb,c4.rgb,IN.color.b);

            //o.Albedo = res.rgb;

            o.Albedo = c.rgb*(1-(IN.color.r+IN.color.g+IN.color.b)) +
            c2.rgb*IN.color.r+
            c3.rgb*IN.color.g+
            c4.rgb*IN.color.b;

            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
