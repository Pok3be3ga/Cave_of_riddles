using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Die : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    private void OnTriggerEnter(Collider other)
    {
        if (other.attachedRigidbody)
        {
            PlayerVR player = other.attachedRigidbody.GetComponent<PlayerVR>();
            if (player)
            {
                player.Die();
            }
        }
    }



}
