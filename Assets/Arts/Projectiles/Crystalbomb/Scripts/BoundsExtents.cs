using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BoundsExtents : MonoBehaviour
{
    public float BoundsExtent = 2f;

    [ContextMenu("FF")]
    private void UpdateF()
    {
        //GetComponent<Renderer>().bounds = new Bounds(transform.position, Vector3.one * BoundsExtent);
        var comp = GetComponent<Renderer>();
        var bounds = comp.bounds;
        GetComponent<MeshFilter>().sharedMesh.bounds = new Bounds(transform.position, Vector3.one * BoundsExtent);
        bounds.Expand(200f);
        bounds.extents = new Vector3(2f,2f,2f);// (new Bounds(transform.position, Vector3.one * BoundsExtent));
    }

    private void OnDrawGizmosSelected()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawWireCube(GetComponent<MeshFilter>().sharedMesh.bounds.center, GetComponent<MeshFilter>().sharedMesh.bounds.size);
    }
}
