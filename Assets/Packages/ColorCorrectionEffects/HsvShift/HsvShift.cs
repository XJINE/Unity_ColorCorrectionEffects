using UnityEngine;

[ExecuteAlways]
[RequireComponent(typeof(Camera))]
public class HsvShift : ImageEffectBase
{
    #region Field

    public Vector4 shift = new (0, 0, 0, 1);

    private static readonly int PropIdShift = 0;

    #endregion Field

    #region Method

    static HsvShift()
    {
        PropIdShift = Shader.PropertyToID("_Shift");
    }

    protected override void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        material.SetVector(PropIdShift, shift);
        base.OnRenderImage(source, destination);
    }

    #endregion Method
}