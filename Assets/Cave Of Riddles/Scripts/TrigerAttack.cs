using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class TrigerAttack : MonoBehaviour
{
    [SerializeField] private UnityEvent _attack;
    private Transform _playerTransform;

    private void Start()
    {
        
    }

    private void FixedUpdate()
    {
       
    }
    private void OnTriggerEnter(Collider other)
    {
        if (other.attachedRigidbody)
        {
            if (other.attachedRigidbody.GetComponent<PlayerVR>())
            {
                _attack.Invoke();
               // PlayerTransform();   
            }
        }

    }

    
    
   
}
