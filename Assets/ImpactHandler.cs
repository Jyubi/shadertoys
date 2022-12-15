using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// [RequireComponent(typeof(MeshRenderer))]
// public class ImpactHandler : MonoBehaviour
// {
//     private Material m_material;
//     // Start is called before the first frame update
//     void Start()
//     {
//         MeshRenderer meshRenderer = GetComponent<MeshRenderer>();
//         m_material = meshRenderer.material;
//     }
//
//     // Update is called once per frame
//     void Update()
//     {
//         m_material.SetFloat("_Glossiness", Mathf.Sin(Time.time) * 0.5f + 0.5f);
//         //M_material.SetTextureOffset("_MainTex", new Vectp);
//
//         Vector3 hitPos = collision.contacts[0].point;
//         m_material.SetVector("_HitPos", hitPos);
//     }
// }