using UnityEngine;

[ExecuteAlways]
[RequireComponent(typeof(Camera))]
public class BrightnessSaturationContrast : ImageEffectBase
{
    #region Field

    public Vector4 @params = new (1, 1, 1, 0);

    protected static int PropIdParams = 0;

    #endregion Field

    #region Method

    static BrightnessSaturationContrast()
    {
        PropIdParams = Shader.PropertyToID("_Params");
    }

    protected override void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        material.SetVector(PropIdParams, @params);
        base.OnRenderImage(source, destination);
    }

    #endregion Method
}