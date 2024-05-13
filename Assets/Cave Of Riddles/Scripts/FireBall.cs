using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Autohand;

public class FireBall : MonoBehaviour
{

    Transform _playerTransform;
    [SerializeField] GameObject Player;
    public ParticleSystem Efect;
    public ParticleSystem Efect2;

    [SerializeField] float Speed = 0.1f;
    public AudioSource ShieldAudio;

    void Start()
    {
        _playerTransform = FindObjectOfType<HeadPhysicsFollower>().transform;
        Player = FindObjectOfType<HeadPhysicsFollower>().gameObject;
    }

    private void FixedUpdate()
    {
        transform.position = Vector3.MoveTowards(transform.position, _playerTransform.position, Time.deltaTime * Speed);       
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.attachedRigidbody)
        {
            if (other.attachedRigidbody.GetComponent<DistanceGrabbable>());
            {
                ShieldAudio.Play();
                Destroy(gameObject);
                Instantiate(Efect2, transform.position, transform.rotation);
            }

        }
        if (other.attachedRigidbody ) 
        {
            if (other.attachedRigidbody.GetComponent<PlayerVR>() || other.GetComponent<HeadPhysicsFollower>() || other.CompareTag("Hand"))
            {
                FindObjectOfType<PlayerVR>().TakeDamageTriger();
                Destroy(gameObject);
                Instantiate(Efect, transform.position, transform.rotation);
            }
        }



        Destroy(gameObject);
        

    }
}
