using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using UnityEngine.Events;
public class Fire : MonoBehaviour
{
    [SerializeField] private float _timer;

    private void Start()
    {
    }

    void Update()
    {

        _timer += Time.deltaTime;
        if (_timer >= 2)
        {
            Die();
        }
    }
    private void OnTriggerEnter(Collider other)
    {
        if (other.attachedRigidbody)
        {
            if (other.attachedRigidbody.GetComponent<PlayerVR>())
            {
                FindObjectOfType<PlayerVR>().TakeDamageTriger();
            }
        }

    }
    private void Die()
    {
        Destroy(gameObject);
    }

}
