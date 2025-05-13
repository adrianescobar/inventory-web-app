<template>
  <div>
    <h2>Edit Equipment</h2>
    <EquipmentForm :equipmentTypes="equipmentTypes" :formData="equipmentData" @save="updateEquipment" />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import EquipmentForm from '../../components/equipments/EquipmentForm.vue';
import axios from 'axios';
import { API_BASE_URL } from '../../env.js';

const router = useRouter();
const route = useRoute();
const equipmentTypes = ref([]);
const equipmentData = ref({});

async function fetchEquipmentTypes() {
  try {
      const response = await axios.get(`${API_BASE_URL}/EquipmentType`);
      console.log('Fetched equipment types:', response.data);
      equipmentTypes.value = response.data;
  } catch (error) {
      console.error('Error fetching equipment types:', error);
  }
}

async function fetchEquipmentData(id) {
  try {
      const response = await axios.get(`${API_BASE_URL}/equipment/${id}`);
      console.log('Fetched equipment data:', response.data);
      equipmentData.value = response.data;
  } catch (error) {
      console.error('Error fetching equipment data:', error);
  }
}

async function updateEquipment(data) {
  try {
      console.log('Updating equipment:', data);
      await axios.put(`${API_BASE_URL}/equipment/${data.id}`, data);
      router.push('/equipments');
  } catch (error) {
      console.error('Error updating equipment:', error);
  }
}

onMounted(() => {
  fetchEquipmentTypes();
  const equipmentId = route.params.id;
  if (equipmentId) {
      fetchEquipmentData(equipmentId);
  }
});
</script>
