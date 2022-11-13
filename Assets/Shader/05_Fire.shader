Shader "Custom/05_Fire"
{
    Properties
    {
      
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MainTex2 ("Second Tex", 2D) = "white" {}

     
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard alpha:fade

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _MainTex2;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MainTex2;

        };

       

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 secondTex= tex2D(_MainTex2, float2(IN.uv_MainTex2.x,IN.uv_MainTex2.y-_Time.y));
            o.Emission = c.rgb * secondTex.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
