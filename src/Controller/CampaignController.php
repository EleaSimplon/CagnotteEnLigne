<?php

namespace App\Controller;

use App\Entity\Campaign;
use App\Entity\Participant;
use App\Entity\Payment;
use App\Entity\Image;
use App\Form\CampaignType;
use Symfony\Component\HttpFoundation\JsonResponse;
use App\Repository\CampaignRepository;
use App\Repository\ImageRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/campaign")
 */
class CampaignController extends AbstractController
{
    /**
     * @Route("/", name="campaign_index", methods={"GET"})
     */
    public function index(CampaignRepository $campaignRepository): Response
    {
        return $this->render('campaign/index.html.twig', [
            'campaigns' => $campaignRepository->findAll(),
            'user' =>$this->getUser(),
        ]);
    }

    /**
     * @Route("/new", name="campaign_new", methods={"GET","POST"})
     */
    public function new(Request $request): Response
    {

        $inputName = $request->get('name');
        $user = $this->getUser();

        $campaign = new Campaign();
        $form = $this->createForm(CampaignType::class, $campaign);
        $form->handleRequest($request);

        if (!$this->getUser()){
            return $this->redirectToRoute('app_login');
        }

        if ($form->isSubmitted() && $form->isValid()) {

            // RECUP IMAGES TRANSMISES
            $images = $form->get('images')->getData();
            
            // MULTIPLES IMAGES = BOUCLE IMAGES
            foreach ($images as $image){
                // GENERE NEW NOM FICHIER
                $fichier = md5(uniqid()) . '.' . $image->guessExtension();

                // ON COPY FICHIER IN DOSSIER IMAGES. 2 PARAMS : DESTINATION DE L'IMG + FICHIER
                $image->move(
                    $this->getParameter('images_directory'),
                    $fichier
                );

                // ENREGISTRER EN DB (NAME)
                $img = new Image();
                $img->setName($fichier);
                $campaign->addImage($img);
            }

            $campaign->setUser($this->getUser());

            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->persist($campaign);
            $entityManager->flush();

            return $this->redirectToRoute('campaign_index');
        }

        return $this->render('campaign/new.html.twig', [
            'campaign' => $campaign,
            'formCreate' => $form->createView(),
            'inputValue' => $inputName,
            'user'=>$user,
            'userName' => $this->getUser()->getUserName(),
            'userMail' => $this->getUser()->getEmail(),
        ]);
    }

    /**
     * @Route("/{id}", name="campaign_show", methods={"GET"})
     */
    public function show(Campaign $campaign)
    {
        $participantsRepository = $this->getDoctrine()
                                       ->getRepository(Participant::class);
        $participants = $participantsRepository->findBy(['campaignId' => $campaign->getId()]);

        $paymentRepository = $this->getDoctrine()
                                  ->getRepository(Payment::class);
        $payments = $paymentRepository->findBy(['participantId' => $participants]);

        $imagesRepository = $this->getDoctrine()
                                 ->getRepository(Image::class);
        $images = $imagesRepository->findBy(['campaign' => $campaign], ['id' => 'DESC'], 2);
  
        
        return $this->render('campaign/show.html.twig', [
            'images'=>$images,
            'campaign' => $campaign,
            'payments' => $payments,
            'user' =>$this->getUser()
        ]);
    }

    /**
     * @Route("/{id}/edit", name="campaign_edit", methods={"GET","POST"})
     */
    public function edit(Request $request, Campaign $campaign): Response
    {
        $form = $this->createForm(CampaignType::class, $campaign);
        $form->handleRequest($request);

        $imagesRepository = $this->getDoctrine()
                                 ->getRepository(Image::class);
        $images = $imagesRepository->findBy(['campaign' => $campaign], ['id' => 'DESC'], 2);
        
        if ($form->isSubmitted() && $form->isValid()) {

            // RECUP IMAGES TRANSMISES
            $images = $form->get('images')->getData();
            
            // MULTIPLES IMAGES = BOUCLE IMAGES
            foreach ($images as $image){
                // GENERE NEW NOM FICHIER
                $fichier = md5(uniqid()) . '.' . $image->guessExtension();

                // ON COPY FICHIER IN DOSSIER IMAGES. 2 PARAMS : DESTINATION DE L'IMG + FICHIER
                $image->move(
                    $this->getParameter('images_directory'),
                    $fichier
                );

                // ENREGISTRER EN DB (NAME)
                $img = new Image();
                $img->setName($fichier);
                $campaign->addImage($img);
            }

            $this->getDoctrine()->getManager()->flush();

            return $this->redirectToRoute('campaign_index');
        }

        return $this->render('campaign/edit.html.twig', [
            'images' => $images,
            'campaign' => $campaign,
            'formEdit' => $form->createView(),
            'inputValue' => '',
            'userName' => $this->getUser()->getUserName(),
            'userMail' => $this->getUser()->getEmail(),
        ]);
    }

    /**
     * @Route("/{id}", name="campaign_delete", methods={"POST"})
     */
    public function delete(Request $request, Campaign $campaign): Response
    {
        if ($this->isCsrfTokenValid('delete'.$campaign->getId(), $request->request->get('_token'))) {
            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->remove($campaign);
            $entityManager->flush();
        }

        return $this->redirectToRoute('campaign_index');
    }

    /**
     * @Route("/delete/image/{id}", priority=10 ,name="campaign_delete_image", methods={"DELETE"})
     */
    public function deleteImg(Image $image, Request $request){

        $data = json_decode($request->getContent(), true);
        
        // VERIF SI TOKEN VALIDE
        if($this->isCsrfTokenValid('delete'.$image->getId(), $data['_token'])){
            //RECUP NOM IMG
            $name = $image->getName();
            // SUP FICHIER
            unlink($this->getParameter('images_directory').'/'.$name);

            // SUP DE LA DB
            $em = $this->getDoctrine()->getManager();
            $em->remove($image);
            $em->flush();

            // REP EN JSON
            return new JsonResponse(['success' => 1]);
        }else {
            return new JsonResponse(['error' => 'Token Invalide'], 400);
        }
    
    }

}
