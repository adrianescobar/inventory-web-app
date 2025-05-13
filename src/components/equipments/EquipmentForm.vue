<template>
    <div>
        <form @submit.prevent="submitForm">
            <input v-model="form.id" type="hidden" />
            <div class="mb-3">
                <label for="brand" class="form-label">Brand</label>
                <input v-model="form.brand" type="text" class="form-control" id="brand" required>
            </div>
            <div class="mb-3">
                <label for="model" class="form-label">Model</label>
                <input v-model="form.model" type="text" class="form-control" id="model" required>
            </div>
            <div class="mb-3">
                <label for="equipmentType" class="form-label">Equipment Type</label>
                <Multiselect 
                    v-model="form.equipmentTypeId" 
                    mode="single" 
                    :searchable="true"
                    :options="mappedEquipments" 
                    aria-required="true"
                    required="true"
                />
            </div>
            <div class="mb-3">
                <label for="purchaseDate" class="form-label">Purchase Date</label>
                <input v-model="form.purchaseDate" type="date" class="form-control" id="purchaseDate" required>
            </div>
            <div class="mb-3">
                <label for="serialNumber" class="form-label">Serial Number</label>
                <input v-model="form.serialNumber" type="text" class="form-control" id="serialNumber">
            </div>
            <button type="submit" class="btn btn-success me-2">Save</button>
            <button @click="goBack" class="btn btn-secondary">Cancel</button>
        </form>
    </div>
</template>

<script setup>
import { defineProps, defineEmits, reactive, toRefs, watch, computed } from 'vue';
import { useRouter } from 'vue-router';
import Multiselect from '@vueform/multiselect';
import moment from 'moment';

const router = useRouter();

function goBack() {
    router.back();
}

const props = defineProps({
    equipmentTypes: {
        type: Array,
        required: true,
        default: () => [],
        validator: (value) => {
            return value.every(item =>
                typeof item === 'object' &&
                typeof item.id === 'number' &&
                typeof item.description === 'string'
            );
        }
    },
    formData: {
        type: Object,
        required: false,
        default: () => ({})
    }
});

const emit = defineEmits(['save']);
const form = reactive({
    id: null,
    brand: '',
    model: '',
    equipmentTypeId: '',
    purchaseDate: '',
    serialNumber: ''
});

const mappedEquipments = computed(() => {
    return props.equipmentTypes?.map(item => ({
        label: item.description,
        value: item.id
    }));
});


watch(() => props.formData, (newValue) => {
    if (newValue.purchaseDate) {
        newValue.purchaseDate = moment(newValue.purchaseDate).format('YYYY-MM-DD');
    }
    Object.assign(form, newValue);
}, { immediate: true });

function submitForm() {
    emit('save', { ...form });
}

</script>

<style src="@vueform/multiselect/themes/default.css"></style>

<style>
.multiselect {
    width: 100%;
}
</style>
