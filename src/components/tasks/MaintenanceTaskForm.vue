<template>
    <div>
        <form @submit.prevent="submitForm">
            <div class="mb-3">
                <label for="description" class="form-label">Description</label>
                <input v-model="form.description" type="text" class="form-control" id="description" required>
            </div>
            <div class="mb-3">
                <label for="equipments" class="form-label">Equipments</label>
                <Multiselect 
                    v-model="form.equipments" 
                    mode="tags" 
                    :close-on-select="false" 
                    :searchable="true"
                    :options="mappedEquipments" 
                    aria-required="true"
                    required="true"
                />

            </div>
            <button type="submit" class="btn btn-success">Save</button>
        </form>
    </div>
</template>

<script setup>
import { reactive, computed, watch, defineProps, defineEmits  } from 'vue';
import Multiselect from '@vueform/multiselect';

const props = defineProps({
    equipmentOptions: {
        type: Array,
        required: true,
        default: () => []
    },
    taskData: {
        type: Object,
        required: false,
        default: () => ({})
    }
});

const emit = defineEmits(['save']);
const form = reactive({
    id: null,
    description: '',
    equipments: []
});

const mappedEquipments = computed(() => {
    return props.equipmentOptions.map(item => ({
        label: `${item.brand} - ${item.model}`,
        value: item.id
    }));
});

watch(() => props.taskData, (newValue) => {
    if (newValue) {
        form.id = newValue.id;
        form.description = newValue.description;
        form.equipments = newValue.equipments?.map(equipment => (equipment.id));
    }
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
