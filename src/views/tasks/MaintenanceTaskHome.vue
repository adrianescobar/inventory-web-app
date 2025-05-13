<template>
    <div>
        <h2>Maintenance Task Home</h2>
        <button class="btn btn-primary mb-3" @click="goToAddMaintenanceTask">Add Task</button>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Id</th>
                    <th>Description</th>
                    <th>Equipments</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="task in maintenanceTasks" :key="task.id">
                    <td>{{ task.id }}</td>
                    <td>{{ task.description }}</td>
                    <td>
                        <span v-for="(equipment, index) in task.equipments" :key="equipment.id">
                            {{ equipment.brand }} {{ equipment.model }} ({{ equipment.equipmentType.description }})<span v-if="index < task.equipments.length - 1">, </span>
                        </span>
                    </td>
                    <td>
                        <button class="btn btn-warning btn-sm me-2" @click="goToEditMaintenanceTask(task.id)">Edit</button>
                        <button class="btn btn-danger btn-sm" @click="openDeleteModal(task.id)">Delete</button>
                    </td>
                </tr>
            </tbody>
        </table>

        <!-- Delete Confirmation Modal -->
        <DeleteConfirmation modalId="deleteModalComponent" msj="Are you sure you want to delete this maintenance task?" @confirm="deleteMaintenanceTask" />
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import axios from 'axios';
import { API_BASE_URL } from '../../env.js';
import DeleteConfirmation from '../../components/DeleteConfirmation.vue';

const maintenanceTasks = ref([]);
const selectedId = ref(null);
const deleteModal = ref(null);
const router = useRouter();

async function fetchMaintenanceTasks() {
    try {
        const response = await axios.get(`${API_BASE_URL}/maintenanceTask`);
        maintenanceTasks.value = response.data;
    } catch (error) {
        console.error('Error fetching maintenance tasks:', error);
    }
}

async function openDeleteModal(id) {
    selectedId.value = id;
    if (!deleteModal.value) {
        const { Modal } = await import('bootstrap');
        deleteModal.value = new Modal(document.getElementById('deleteModalComponent'));
    }
    deleteModal.value.show();
}

async function deleteMaintenanceTask() {
    try {
        await axios.delete(`${API_BASE_URL}/maintenanceTask/${selectedId.value}`);
        maintenanceTasks.value = maintenanceTasks.value.filter(item => item.id !== selectedId.value);
        console.log('Maintenance task deleted successfully');
        if (deleteModal.value) {
            deleteModal.value.hide();
        }
    } catch (error) {
        console.error('Error deleting maintenance task:', error);
    }
}
async function goToAddMaintenanceTask() {
    router.push('/tasks/add');
}

async function goToEditMaintenanceTask(id) {
    router.push(`/tasks/${id}`);
}

onMounted(() => {
    fetchMaintenanceTasks();
});
</script>

<style>
.table {
    width: 100%;
    margin-bottom: 1rem;
}
</style>
