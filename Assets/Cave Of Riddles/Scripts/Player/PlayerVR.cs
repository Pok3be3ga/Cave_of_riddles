using System.Collections;
using System.Collections.Generic;
using UnityEngine.SceneManagement;
using UnityEngine;
using UnityEngine.Events;
using TMPro;
using Autohand.Demo;

public class PlayerVR : MonoBehaviour
{

    public int Health = 3;
    public int MaxHealth = 4;
    public GameObject Player;
    public AudioSource DamageSound;
    public AudioSource DeadSound;
    public Transform SpawnTransform;
    public float imp;
    public PlayerFallCatcher PlayerFallCatcher;

    public HealthPlayer HealthPlayer;
    public bool Grounded;
    [SerializeField] private bool _invunerable = false;
    public float I = 50f;

    private CapsuleCollider _startCapsuleCollider;
    private CapsuleCollider _basicCapsuleCollider;

    private void Start()
    {
        //HealthPlayer.Setup(Health);
        //HealthPlayer.DisplayHealth(Health);
    }
    private void Update()
    {

    }
    public void TakeDamageTriger()
    {
        if (_invunerable == false)
        {
            DamageSound.Play();
            Health -= 1;
            HealthPlayer.DisplayHealth(Health);
            _invunerable = true;
            Invoke("StopInvulnerable", 0.5f);
            PlayerFallCatcher.DamageScan();
        }        
    }

    void StopInvulnerable()
    {
        _invunerable = false;
    }

    public void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("CheckPOint"))
        {
            FindObjectOfType<PlayerFallCatcher>().CreateCheck();
        }
    }
    


    public void Die()
    {
        if (_invunerable == false)
        {
            CapsuleCollider _startCapsuleCollider = GetComponent<CapsuleCollider>();
            Health = 0;
            PlayerFallCatcher.DamageScan();
            DeadSound.Play();
            _invunerable = true;
            Invoke("StopInvulnerable", 0.5f);
        }
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.impulse.y > I)
        {
            Die();
        }
    }
}

