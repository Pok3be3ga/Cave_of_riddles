using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StartPosition1 : MonoBehaviour
{
    // Start is called before the first frame update
    private Vector3 startPosition;
    private Quaternion startRotation;
    void Start()
    {
        startPosition = transform.position;
        startRotation = transform.rotation;
        gameObject.GetComponent<Rigidbody>().isKinematic = true;
    }

    public void Back()
    {
        gameObject.transform.position = startPosition;
        gameObject.transform.rotation = startRotation;
        gameObject.GetComponent<Rigidbody>().isKinematic = true;
    }
}
