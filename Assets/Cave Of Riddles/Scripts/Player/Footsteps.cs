using System;
using UnityEngine;
using System.Collections;
using Autohand;

public class Footsteps : MonoBehaviour
{
    [SerializeField] AudioClip[] _footstepSounds;
    [SerializeField] float _stepDistance = 0.6f;
    [SerializeField] float _volume = 0.5f;

    AudioSource _audioSource;
    private Vector3 _lastPosition;
    private float _distanceSinceLastStep = 0f;
    public Action stepAction;
    [SerializeField] bool _enabled = true;

    [SerializeField] AutoHandPlayer AutoHandPlayer;

    private void Start()
    {
        //AutoHandPlayer.isGrounded = _enabled;
    }
    private void Awake()
    {
        _audioSource = GetComponent<AudioSource>();
        _audioSource.volume = _volume;
        _lastPosition = transform.position;
    }

    private void Update()
    {

        if (AutoHandPlayer.IsGrounded())
        {
            _distanceSinceLastStep += Vector3.Distance(transform.position, _lastPosition);
            _lastPosition = transform.position;

            if (_distanceSinceLastStep >= _stepDistance)
            {
                AudioClip footstepSound = _footstepSounds[UnityEngine.Random.Range(0, _footstepSounds.Length)];

                _audioSource.PlayOneShot(footstepSound);
                stepAction?.Invoke();

                _distanceSinceLastStep = 0f;
            }
        }
    }
}