using UnityEngine;

[ExecuteAlways]
[RequireComponent(typeof(Camera))]
public class HsvShift : ImageEffectBase
{
    #region Field

    public Vector4 shift = new Vector4(0, 0, 0, 1);

    protected static int PropIdShift = 0;

    #endregion Field

    #region Method

    static HsvShift()
    {
        PropIdShift = Shader.PropertyToID("_Shift");
    }

    protected override void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        base.material.SetVector(PropIdShift, this.shift);
        base.OnRenderImage(source, destination);
    }

    #endregion Method
}