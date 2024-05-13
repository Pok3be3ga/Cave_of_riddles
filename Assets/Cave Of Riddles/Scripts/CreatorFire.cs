using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class CreatorFire : MonoBehaviour
{

    public GameObject FirePrefab;
    public GameObject Particle;
    public ParticleSystem ParticleSystem;
    public AudioSource FireSound;
    public Transform Creator;
    public UnityEvent UnityEvent;

    float _timer;
    public float TimerFire = 7f;



    void Start()
    {
       
    }
    

    private void FixedUpdate()
    {  

    }

    void Update()
    {


        _timer += Time.deltaTime;
        if(_timer >= TimerFire)
        {
            Create();
        }
        if(_timer <= 2)
        {
            Particle.SetActive(true);
            ParticleSystem.Play();



        }
        else
        {
            Particle.SetActive(false);
            ParticleSystem.Pause();
        }


    }


    public void Create()
    {

        {
            _timer = 0;
            GameObject newFire = Instantiate(FirePrefab, Creator.position, Creator.rotation);

            FireSound.Play();


        }
    }
    
}
