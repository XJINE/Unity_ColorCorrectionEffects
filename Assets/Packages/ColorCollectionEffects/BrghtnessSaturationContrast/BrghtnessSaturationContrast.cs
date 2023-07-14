using UnityEngine;

[ExecuteAlways]
[RequireComponent(typeof(Camera))]
public class BrghtnessSaturationContrast : ImageEffectBase
{
    #region Field

    public Vector4 @params = new Vector4(1, 1, 1, 0);

    protected static int PropIdParams = 0;

    #endregion Field

    #region Method

    static BrghtnessSaturationContrast()
    {
        PropIdParams = Shader.PropertyToID("_Params");
    }

    protected override void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        base.material.SetVector(PropIdParams, this.@params);
        base.OnRenderImage(source, destination);
    }

    #endregion Method
}