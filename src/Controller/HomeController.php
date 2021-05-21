<?php

namespace App\Controller;

use App\Entity\Campaign;
use App\Entity\Participant;
use App\Entity\Payment;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use App\Repository\CampaignRepository;
use App\Repository\PaymentRepository;
use App\Repository\ParticipantRepository;

class HomeController extends AbstractController
{
    /**
     * @Route("/", name="home")
     */
    public function index(CampaignRepository $campaignRepository, PaymentRepository $paymentRepository, ParticipantRepository $participantRepository): Response
    {
        $campaign = $campaignRepository->findBy([], [], 5, 0); // 5 = 5 first campaign, 0 = start from 0 //

        $participants = $participantRepository->findBy(['campaignId' => $campaign]);

        $payments = $paymentRepository->findBy(['participantId' => $participants]);

        return $this->render('home/index.html.twig', [
            'campaigns' => $campaign,
            'payments' => $payments,
            'participants' => $participants,
            
        ]);
    }

}