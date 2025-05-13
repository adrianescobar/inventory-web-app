<template>
    <div>
        <h2>Equipment Page</h2>
        <button class="btn btn-primary mb-3" @click="goToEquipmentAddForm">Add Equipment</button>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Id</th>
                    <th>Brand</th>
                    <th>Model</th>
                    <th>Equipment Type</th>
                    <th>Purchase Date</th>
                    <th>Serial Number</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(item, index) in equipmentList" :key="index">
                    <td>{{ item.id }}</td>
                    <td>{{ item.brand }}</td>
                    <td>{{ item.model }}</td>
                    <td>{{ item.equipmentType.description }}</td>
                    <td>{{ moment(item.purchaseDate).format('YYYY-MM-DD') }}</td>
                    <td>{{ item.serialNumber }}</td>
                    <td>
                        <button class="btn btn-warning btn-sm me-2" @click="goToEquipmentEditForm(item.id)">Edit</button>
                        <button class="btn btn-danger btn-sm" @click="openDeleteModal(item.id)">Delete</button>
                    </td>
                </tr>
            </tbody>
        </table>

        <DeleteConfirmation modalId="deleteModalComponent" msj="Are you sure you want delete this equipment?"
            @confirm="deleteEquipment" />
    </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import DeleteConfirmation from '../../components/DeleteConfirmation.vue';
import axios from 'axios';
import { API_BASE_URL } from '../../env.js';
import moment from 'moment';

interface EquipmentType {
    id: number;
    description: string;
}

interface Equipment {
    id: number;
    brand: string;
    model: string;
    equipmentType: EquipmentType;
    purchaseDate: string;
    serialNumber: string;
}

const router = useRouter();

const equipmentList = ref<Equipment[]>([]);
const selectedId = ref<number | null>(null);
const deleteModal = ref<any>(null);

async function fetchEquipment() {
    try {
        const response = await axios.get(`${API_BASE_URL}/equipment`);
        console.log('Fetched equipment:', response.data);
        equipmentList.value = response.data;
    } catch (error) {
        console.error('Error fetching equipment:', error);
    }
}

async function openDeleteModal(id: number) {
    selectedId.value = id;
    if (!deleteModal.value) {
        const { Modal } = await import('bootstrap');
        deleteModal.value = new Modal(document.getElementById('deleteModalComponent'));
    }

    deleteModal.value.show();
}

async function deleteEquipment() {

    try {

        await axios.delete(`${API_BASE_URL}/equipment/${selectedId.value}`);
        equipmentList.value = equipmentList.value.filter(item => item.id !== selectedId.value);
        console.log('Equipment deleted successfully');
    } catch (error) {
        console.error('Error deleting equipment:', error);
    }
    finally {
        selectedId.value = null;
        if (deleteModal.value) {
            deleteModal.value.hide();
        }
    }
}

async function goToEquipmentAddForm() {
    router.push('/equipments/add');
}

async function goToEquipmentEditForm(id: number) {
    router.push(`/equipments/${id}`);
}

onMounted(() => {
    fetchEquipment();
});
</script>

<style>
.table {
    width: 100%;
    margin-bottom: 1rem;
}
</style>