<template>
    <div>
        <h2>Add Task</h2>
        <MaintenanceTaskForm :equipmentOptions="equipmentOptions" @save="saveMaintenanceTask" />
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import axios from 'axios';
import MaintenanceTaskForm from '../../components/tasks/MaintenanceTaskForm.vue';
import { API_BASE_URL } from '../../env.js';

const router = useRouter();
const equipmentOptions = ref([]);

async function fetchEquipments() {
    try {
        const response = await axios.get(`${API_BASE_URL}/equipment`);
        equipmentOptions.value = response.data;
    } catch (error) {
        console.error('Error fetching equipments:', error);
    }
}

async function saveMaintenanceTask(data) {
    try {
        await axios.post(`${API_BASE_URL}/maintenanceTask`, data);
        router.push('/tasks');
    } catch (error) {
        console.error('Error saving maintenance task:', error);
    }
}

onMounted(() => {
    fetchEquipments();
});
</script>
