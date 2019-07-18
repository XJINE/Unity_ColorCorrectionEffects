using UnityEngine;

[ExecuteAlways]
[RequireComponent(typeof(Camera))]
public class ColorCollection : ImageEffectBase
{
    #region Field

    public Vector4 bscParams = new Vector4(1, 1, 1, 0);
    public Vector4 hsvShift  = new Vector4(0, 0, 0, 1);

    protected static int PropIdBscParams = 0;
    protected static int PropIdHsvShift = 0;

    #endregion Field

    #region Method

    static ColorCollection()
    {
        PropIdBscParams = Shader.PropertyToID("_BscParams");
        PropIdHsvShift  = Shader.PropertyToID("_HsvShift");
    }

    protected override void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        base.material.SetVector(PropIdBscParams, this.bscParams);
        base.material.SetVector(PropIdHsvShift, this.hsvShift);
        base.OnRenderImage(source, destination);
    }

    #endregion Method
}