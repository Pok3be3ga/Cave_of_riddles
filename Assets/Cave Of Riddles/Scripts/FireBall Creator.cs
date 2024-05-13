using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UIElements;

public class FirreBallCreator : MonoBehaviour
{
    private Transform startTransform;
    private Transform _playerTransform;

    public float timerKd = 1f;
    public float Speed = 5f;
    float _timer;

    public float MaxDistance;

    public GameObject FireBallPrefab;
    public Transform Spawn;

    public AudioSource PreCannonSound;
    public AudioSource CannonSound;

    public float Distance;

    private void Start()
    {
        startTransform = GetComponent<Transform>();
    }

    private void Update()
    {
        _timer += Time.deltaTime;
        _playerTransform = FindObjectOfType<PlayerVR>().transform;
        Distance = Vector3.Distance(startTransform.position, _playerTransform.position);

        if (_timer > timerKd && Math.Abs(Distance) < MaxDistance)
        {
            PreCannonSound.Play();
            Invoke("Fire", 2.3f);
            _timer = 0;
        }   
    }

    private void Fire()
    {
        CannonSound.Play();
        GameObject NewFireBall = Instantiate(FireBallPrefab, Spawn.position, startTransform.rotation);        
    }
}





