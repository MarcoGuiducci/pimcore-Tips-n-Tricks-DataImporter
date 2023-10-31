<?php

namespace App\Mapping\Operator\Simple;

use Pimcore\Bundle\DataImporterBundle\Exception\InvalidConfigurationException;
use Pimcore\Bundle\DataImporterBundle\Mapping\Operator\AbstractOperator;
use Pimcore\Bundle\DataImporterBundle\Mapping\Type\TransformationDataTypeService;

class CaseConversion extends AbstractOperator
{
    /**
     * @var string
     */
    protected $caseConversion;

    public function setSettings(array $settings): void
    {
        $this->caseConversion = $settings['caseConversion'] ?? 'strtolower';
    }

    public function process($inputData, bool $dryRun = false)
    {
        $returnScalar = false;
        if (!is_array($inputData)) {
            $returnScalar = true;
            $inputData = [$inputData];
        }

        $result = [];
        foreach ($inputData as &$data) {
            $result[] = ($this->caseConversion)($data);
        }

        if ($returnScalar) {
            if (!empty($result)) {
                return reset($result);
            }

            return null;
        } else {
            return $result;
        }
    }

    public function evaluateReturnType(string $inputType, int $index = null): string
    {
        if (!in_array($inputType, [TransformationDataTypeService::DEFAULT_TYPE, TransformationDataTypeService::DEFAULT_ARRAY])) {
            throw new InvalidConfigurationException(sprintf("Unsupported input type '%s' for simple test operator at transformation position %s", $inputType, $index));
        }

        return $inputType;
    }
}
