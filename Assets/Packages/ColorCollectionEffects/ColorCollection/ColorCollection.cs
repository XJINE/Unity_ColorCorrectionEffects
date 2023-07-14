using UnityEngine;

[ExecuteAlways]
[RequireComponent(typeof(Camera))]
public class ColorCollection : ImageEffectBase
{
    #region Field

    public Vector4 bscParams = new (1, 1, 1, 0);
    public Vector4 hsvShift  = new (0, 0, 0, 1);

    private static readonly int PropIdBscParams = 0;
    private static readonly int PropIdHsvShift  = 0;

    #endregion Field

    #region Method

    static ColorCollection()
    {
        PropIdBscParams = Shader.PropertyToID("_BscParams");
        PropIdHsvShift  = Shader.PropertyToID("_HsvShift");
    }

    protected override void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        material.SetVector(PropIdBscParams, bscParams);
        material.SetVector(PropIdHsvShift,  hsvShift);
        base.OnRenderImage(source, destination);
    }

    #endregion Method
}