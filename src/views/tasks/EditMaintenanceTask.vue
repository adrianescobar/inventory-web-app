<template>
    <div>
        <h2>Edit Maintenance Task</h2>
        <MaintenanceTaskForm :equipmentOptions="equipmentOptions" :taskData="taskData" @save="saveMaintenanceTask" />
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import axios from 'axios';
import MaintenanceTaskForm from '../../components/tasks/MaintenanceTaskForm.vue';
import { API_BASE_URL } from '../../env.js';

const router = useRouter();
const route = useRoute();
const equipmentOptions = ref([]);
const taskData = ref({});

async function fetchEquipments() {
    try {
        const response = await axios.get(`${API_BASE_URL}/equipment`);
        equipmentOptions.value = response.data;
    } catch (error) {
        console.error('Error fetching equipments:', error);
    }
}

async function fetchMaintenanceTask(id) {
    try {
        const response = await axios.get(`${API_BASE_URL}/maintenanceTask/${id}`);
        taskData.value = response.data;
    } catch (error) {
        console.error('Error fetching maintenance task:', error);
    }
}

async function saveMaintenanceTask(data) {
    try {
        await axios.put(`${API_BASE_URL}/maintenanceTask/${data.id}`, data);
        router.push('/tasks');
    } catch (error) {
        console.error('Error updating maintenance task:', error);
    }
}

onMounted(() => {
    const taskId = route.params.id;
    if (taskId) {
        fetchMaintenanceTask(taskId);
    }
    fetchEquipments();
});
</script>
