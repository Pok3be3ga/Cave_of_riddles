using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;


namespace Autohand.Demo
{
    public class PlayerFallCatcher : MonoBehaviour
    {

        Vector3 startPos;
        public AudioSource DeadhAudio;
        [SerializeField] Vector3 CheckPointPosition;
        [SerializeField] Quaternion CheckPointRotation;
        public HealthPlayer HealthPlayer;
        public OVRScreenFade OVRScreenFade;

        [SerializeField] AutoHandPlayer AutoHandPlayer;
        Coroutine Coroutine = null;
        public GameObject OculusPlayerBraslet;


        void Start()
        {
            if (AutoHandPlayer.Instance != null)
            {
                CheckPointPosition = AutoHandPlayer.Instance.transform.position;
                //headPhysicsFollower = GameObject.FindObjectOfType<HeadPhysicsFollower>();

            }
        }



        public void CreateCheck()
        {
            Vector3 New = AutoHandPlayer.Instance.transform.position;
            
            CheckPointRotation = AutoHandPlayer.Instance.transform.rotation;
            CheckPointPosition = New;
        }
        public void DamageScan()
        {
            if (PlayerVR.FindObjectOfType<PlayerVR>().Health <= 0)
            {
                Invoke("ReturnPlayer", 1);
                OVRScreenFade.FadeIn();


                //AutoHandPlayer.GetComponent<CapsuleCollider>().enabled = false;
                //Invoke("CapsuleColliderEnabled", 1);
            }
        }

        public void CapsuleColliderEnabled()
        {
            AutoHandPlayer.GetComponent<CapsuleCollider>().enabled = true;
        }

        void ReturnPlayer()
        {
            AutoHandPlayer.Instance.SetPosition(CheckPointPosition);
            
            PlayerVR.FindObjectOfType<PlayerVR>().Health += 4;
            HealthPlayer.DisplayHealth(FindObjectOfType<PlayerVR>().Health);
            AutoHandPlayer.Instance.SetRotation(CheckPointRotation);
        }


    }


}
