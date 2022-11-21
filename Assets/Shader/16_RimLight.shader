Shader "Custom/16_RimLight"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _RimColor ("RimColor", Color) = (1,1,1,1)
        _RimStrengh("RimStrengh",Range(1,10))=3

      
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert 

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;
        };

       
        fixed4 _Color;
        fixed4 _RimColor;
        float _RimStrengh;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
          
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            //Camera Dir /Normal dot
            float rim= saturate(dot(o.Normal,IN.viewDir));

            //Liner Thiner
            o.Emission=pow(1- rim,_RimStrengh)*_RimColor.rgb;
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
