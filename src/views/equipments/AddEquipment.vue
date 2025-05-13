<template>
    <div>
      <h2>Add New Equipment</h2>
      <EquipmentForm :equipmentTypes="equipmentTypes" @save="saveEquipment" />
    </div>
  </template>
  
  <script setup>
  import { ref, onMounted } from 'vue';
  import { useRouter } from 'vue-router';
  import EquipmentForm from '../../components/equipments/EquipmentForm.vue';
  import axios from 'axios';
  import { API_BASE_URL } from '../../env.js';
  
  const router = useRouter();
  const equipmentTypes = ref([]);
  
  async function fetchEquipmentTypes() {
    try {
      const response = await axios.get(`${API_BASE_URL}/EquipmentType`);
      console.log('Fetched equipment types:', response.data);
      equipmentTypes.value = response.data;
    } catch (error) {
      console.error('Error fetching equipment types:', error);
    }
  }
  
  onMounted(() => {
    fetchEquipmentTypes();
  });
  
  async function saveEquipment(data) {
    try {
        console.log('Saving equipment:', data);
      await axios.post(`${API_BASE_URL}/equipment`, data);
      router.push('/equipments');
    } catch (error) {
      console.error('Error saving equipment:', error);
    }
  }
  </script>
  