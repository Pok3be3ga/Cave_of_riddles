using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TriggerFloor : MonoBehaviour
{
    public  float I = 0;
    Coroutine Coroutine = null;

    private void Start()
    {
    }
    private void Update()
    {
    }


    private void OnTriggerEnter(Collider other)
    {

        if (other.attachedRigidbody)
        {
            if (other.attachedRigidbody.GetComponent<PlayerVR>())
            {
                if(Coroutine == null)
                {
                    Coroutine = StartCoroutine(Timer());
                }
                    
            }
        }
        Coroutine = null;

    }
    public IEnumerator Timer()
    {
            yield return new WaitForSeconds(I);
            gameObject.GetComponent<Rigidbody>().isKinematic = false;
    }
}
