using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DestroyWithParticles : MonoBehaviour
{

    public ParticleSystem ParticleSystem;
    public AudioSource AudioSource;
    private void Start()
    {
        AudioSource = gameObject.GetComponent<AudioSource>();
    }
    public void Destroy()
    {
        ParticleSystem particle = Instantiate(ParticleSystem, transform.position, Quaternion.identity);
        Destroy(gameObject);
        AudioSource.Play();
    }
}
